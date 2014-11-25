//
//  JAChapterViewController.m
//  Stories
//
//  Created by Antonin Langlade on 24/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAChapterViewController.h"

@interface JAChapterViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (strong, nonatomic) NSDateFormatter *dateFormater;
@property (strong, nonatomic) NSDateFormatter *dateFormaterFromString;
@property NSUInteger chaptersCount;
@property float chapterHeight;
@property int currentIndex;
@property CGPoint touchPosition;
@property CGPoint positionLoader;
@property UIGestureRecognizerState currentStateTouch;
@property NSTimer *timerForLoader;
@property BOOL touchToLoad;

@end

@implementation JAChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [JAManagerData sharedManager];
    
    self.manager.currentStorie = 0;
    self.manager.currentChapter = 0;
    self.titlesArray = [NSMutableArray array];
    self.currentIndex = -1;
    self.touchToLoad = NO;

    // Date out format
    self.dateFormater = [[NSDateFormatter alloc]init];
    [self.dateFormater setDateFormat:@"MMM,\u00A0dd"];

    // Date in format
    self.dateFormaterFromString = [[NSDateFormatter alloc]init];
    [self.dateFormaterFromString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    // Chapters View
    self.chapterScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/7)];
    self.chapterScrollView.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
    [self.view addSubview:self.chapterScrollView];
    
    // Titles View
    self.titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/7, self.view.bounds.size.width, self.view.bounds.size.height*6/7)];
    self.titlesView.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
    [self.view addSubview:self.titlesView];
    
    [self createTitlesBlocks];

    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.delegate = self;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    // Gesture recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    longPressRecognizer.minimumPressDuration = .05;
    longPressRecognizer.numberOfTouchesRequired = 1;
    longPressRecognizer.delegate = self;
    [self.titlesView addGestureRecognizer:longPressRecognizer];
    


    // Loader View
    self.loaderView = [[JALoaderView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.loaderView.delegate = self;
    self.loaderView.userInteractionEnabled = NO;
    [self.view addSubview:self.loaderView];
}
-(void)createTitlesBlocks{
    // Count for Title View
    self.chaptersCount = [[[self.manager getCurrentChapter] articles] count];
    self.chapterHeight = self.titlesView.frame.size.height / self.chaptersCount;
    
    // Instanciate all titles
    
    for (int i = 0; i < self.chaptersCount ; i++) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, i*self.chapterHeight, self.view.frame.size.width, self.chapterHeight)];
        //        titleView.backgroundColor = [UIColor colorWithRed:1.0/self.chaptersCount *i green:1.0/self.chaptersCount *i blue: 1.0/self.chaptersCount*i alpha:1];
        float percent = 70.0;
        
        NSString *text = [[[[self.manager getCurrentChapter] articles] objectAtIndex:i] title];
        
        NSString *dateString = [[[[self.manager getCurrentChapter] articles] objectAtIndex:i] createdAt];
        
        NSDate *date = [self.dateFormaterFromString dateFromString:dateString];
        NSString *finalDate = [self.dateFormater stringFromDate:date];
        
        NSMutableAttributedString * completeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",text,[finalDate lowercaseString]]];
        [completeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"News-Plantin-Pro-Regular" size:32.0] range:NSMakeRange(0,[text length])];
        [completeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Calibre-Thin" size:20.0] range:NSMakeRange([text length]+1,[finalDate length])];
        
        [completeString addAttribute:NSBaselineOffsetAttributeName value:@(10) range:NSMakeRange([text length]+1,[finalDate length])];
        int rangeFinalUnderline = (int)(percent * [text length] / 100);
        
        [completeString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0,rangeFinalUnderline)];
        
        UILabel *titleLBL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, titleView.frame.size.width - 40, titleView.frame.size.height)];
        titleLBL.lineBreakMode = NSLineBreakByWordWrapping;
        titleLBL.numberOfLines = 0;
        //        titleLBL.backgroundColor = [UIColor blueColor];
        titleLBL.textColor = [UIColor whiteColor];
        titleLBL.attributedText = completeString;
        titleLBL.tag = 1;
        
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:titleLBL];
        titleLBL.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        [titleView addSubview:titleLBL];
        [self.titlesView addSubview:titleView];
        
        [self.titlesArray addObject:titleView];
    }

}
-(void)doubleTap:(UITapGestureRecognizer*)sender{
    [self performSegueWithIdentifier:@"JACoverPop" sender:self];
}
-(void)longPressDetected:(UITapGestureRecognizer *)sender{
    
    self.touchPosition = [sender locationInView:self.titlesView];
    self.currentStateTouch = sender.state;
    bool loadedNextView = NO;
    int index = (int)(self.touchPosition.y/self.chapterHeight);

    [self animateTitlesView:index negativeScale:0.0 negativeAlpha:0.0];
    
    if(self.currentIndex != index){
        NSLog(@"index %i %i",self.currentIndex,index);
        self.touchToLoad = NO;
        [self.loaderView setState:UIGestureRecognizerStateEnded];
        self.currentIndex = index;
        if(self.timerForLoader){
            [self.timerForLoader invalidate];
        }
        
        self.timerForLoader = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(startLoader) userInfo:nil repeats:NO];
    }
    self.positionLoader = [sender locationInView:self.view];

    if(self.touchToLoad == YES){
        [self.loaderView movePosition:self.positionLoader];
        [self.loaderView setState:self.currentStateTouch];
    }
    
    for (int i = index - 1; i >= 0; i--) {
        [self animateTitlesView:i negativeScale:((index-i)*((1.0 /self.titlesArray.count)/2)) negativeAlpha:((index-i) * (1.0 /self.titlesArray.count))];
    }
    for (int i = index + 1; i < [self.titlesArray count]; i++) {
        [self animateTitlesView:i negativeScale:((i - index)*((1.0 /self.titlesArray.count)/2)) negativeAlpha:((i - index)*(1.0 /self.titlesArray.count))];
    }

    if(sender.state == UIGestureRecognizerStateEnded){
        if(loadedNextView == NO){
            [self.timerForLoader invalidate];
            self.touchToLoad = NO;
            self.currentIndex = -1;
            for (int i = 0; i < [self.titlesArray count]; i++) {
                [self animateTitlesView:i negativeScale:.2 negativeAlpha:0.0];
            }
        }
    }
}
// Animate with a negative scale and alpha value
-(void)animateTitlesView:(int)index negativeScale:(float)negativeScale negativeAlpha:(float)negativeAlpha{
    UIView *titleView = [self.titlesArray objectAtIndex:index];
    UILabel *titleLBL = (UILabel*)[titleView viewWithTag:1];

    [UIView animateWithDuration:0.2 animations:^{
        titleLBL.transform = CGAffineTransformMakeScale(1.0 - negativeScale, 1.0 - negativeScale);
        titleLBL.alpha = 1.0 - negativeAlpha;
    } completion:^(BOOL finished) {
    }];

}
-(void)startLoader{
    NSLog(@"Start Loader");
    self.touchToLoad = YES;
    [self.loaderView movePosition:self.positionLoader];
    [self.loaderView setState:UIGestureRecognizerStateBegan];
    
}
-(void)loadNextView{
    
    NSLog(@"ROCKSTAR BABE");
}
-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
