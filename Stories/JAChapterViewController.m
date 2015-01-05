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
@property (strong, nonatomic) NSMutableArray *percentArray;
@property (strong, nonatomic) NSDateFormatter *dateFormater;
@property (strong, nonatomic) NSDateFormatter *dateFormaterFromString;
@property (strong, nonatomic) NSMutableArray *heightCellArray;

@property NSUInteger titleChapterCount;
@property int currentIndex;
@property CGPoint touchPosition;
@property CGPoint positionLoader;
@property UIGestureRecognizerState currentStateTouch;
@property NSTimer *timerForLoader;
@property BOOL touchToLoad;
@property float currentTranslation;


@end

@implementation JAChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [JAManagerData sharedManager];
    
    self.titlesArray = [NSMutableArray array];
    self.percentArray = [NSMutableArray array];
    self.heightCellArray = [NSMutableArray array];
    self.currentIndex = -1;
    self.touchToLoad = NO;
    self.manager.currentChapter = 0;
    self.currentTranslation = 0;
    
    // Date out format
    self.dateFormater = [[NSDateFormatter alloc]init];
    [self.dateFormater setDateFormat:@"MMM,\u00A0dd"];

    // Date in format
    self.dateFormaterFromString = [[NSDateFormatter alloc]init];
    [self.dateFormaterFromString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];

    NSUInteger chaptersCount = [[[self.manager getCurrentStorie] chapters] count];
    
    self.view.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
    
    // Chapters View
    self.chapterScrollView = [[JAChapterScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.bounds.size.height/7)];
    self.chapterScrollView.delegate = self;
    self.chapterScrollView.alpha = 0;
    [self.view addSubview:self.chapterScrollView];
    
    // Titles View
    self.titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/7, self.view.bounds.size.width  * chaptersCount, self.view.bounds.size.height*6/7)];
    self.titlesView.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
    [self.view addSubview:self.titlesView];
    
    for (int i = 0; i < chaptersCount; i++) {
        [self.titlesView addSubview:[self createTitlesBlocks:i]];
    }
    
    
    
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:.5 animations:^{
        self.chapterScrollView.alpha = 1;
    }];

    for (int j = 0; j < [[[self.manager getCurrentStorie] chapters] count]; j++) {

        for (int i = 0; i < [[self.titlesArray objectAtIndex:j] count] ; i++) {
            NSLog(@"i %i",i);
            [self animateTitlesView:i forChapter:j negativeScale:.2 negativeAlpha:.3 delay:i * .05];
        }
    }
    
}
-(UIView*)createTitlesBlocks:(int)index{
    // Count for Title View
    self.titleChapterCount = [[[[[self.manager getCurrentStorie] chapters] objectAtIndex:index] articles] count];
    float chapterHeight = self.titlesView.frame.size.height / self.titleChapterCount;
    NSLog(@"Height %f",chapterHeight);
    
    [self.heightCellArray addObject:[NSNumber numberWithFloat:chapterHeight]];
    
    // Instanciate all titles
    UIView *globalTitleBlock = [[UIView alloc]initWithFrame:CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.titlesView.frame.size.height)];
    NSMutableArray *arrayOfTitle = [NSMutableArray array];
    for (int i = 0; i < self.titleChapterCount ; i++) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, i * chapterHeight, self.view.frame.size.width, chapterHeight)];
;
        float percent = 70.0;

        NSString *text = [[[[[[self.manager getCurrentStorie] chapters]objectAtIndex:index] articles] objectAtIndex:i] title];
        
        NSString *dateString = [[[[[[self.manager getCurrentStorie] chapters] objectAtIndex:index] articles] objectAtIndex:i] createdAt];
        
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
        titleLBL.textColor = [UIColor whiteColor];
        titleLBL.attributedText = completeString;
        titleLBL.tag = 1;
        
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:titleLBL];
        titleLBL.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        [titleView addSubview:titleLBL];
        [globalTitleBlock addSubview:titleView];
        
        [arrayOfTitle addObject:titleView];
    }
    [self.titlesArray addObject:arrayOfTitle];
    return globalTitleBlock;

}
-(void)doubleTap:(UITapGestureRecognizer*)sender{
    [self performSegueWithIdentifier:@"JACoverPop" sender:self];
}
-(void)longPressDetected:(UITapGestureRecognizer *)sender{
    
    self.touchPosition = [sender locationInView:self.titlesView];
    self.currentStateTouch = sender.state;
    bool loadedNextView = NO;
    NSNumber *heightCell = [self.heightCellArray objectAtIndex:self.manager.currentChapter];
    int index = (int)(self.touchPosition.y/heightCell.floatValue);

    [self animateTitlesView:index forChapter:self.manager.currentChapter negativeScale:0.0 negativeAlpha:0.0 delay:0.0];
    
    if(self.currentIndex != index){
        NSLog(@"index %i %i",self.currentIndex,index);
        self.touchToLoad = NO;
        [self.loaderView setState:UIGestureRecognizerStateEnded];
        self.currentIndex = index;
        self.manager.currentArticle = index;
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
        [self animateTitlesView:i forChapter:self.manager.currentChapter negativeScale:((index-i)*((1.0 /[[self.titlesArray objectAtIndex:self.manager.currentChapter]count])/2)) negativeAlpha:((index-i) * (1.0 /[[self.titlesArray objectAtIndex:self.manager.currentChapter]count])) delay:0.0];
    }
    for (int i = index + 1; i < [[self.titlesArray objectAtIndex:self.manager.currentChapter]count]; i++) {
        [self animateTitlesView:i forChapter:self.manager.currentChapter negativeScale:((i - index)*((1.0 /[[self.titlesArray objectAtIndex:self.manager.currentChapter]count])/2)) negativeAlpha:((i - index)*(1.0 /[[self.titlesArray objectAtIndex:self.manager.currentChapter]count])) delay:0.0];
    }

    if(sender.state == UIGestureRecognizerStateEnded){
        if(loadedNextView == NO){
            [self.timerForLoader invalidate];
            self.touchToLoad = NO;
            self.currentIndex = -1;
            for (int i = 0; i < [[self.titlesArray objectAtIndex:self.manager.currentChapter]count]; i++) {
                [self animateTitlesView:i forChapter:self.manager.currentChapter negativeScale:.2 negativeAlpha:0.3 delay:0.0];
            }
        }
    }
}
// Animate with a negative scale and alpha value
-(void)animateTitlesView:(int)index forChapter:(int)chapterIndex negativeScale:(float)negativeScale negativeAlpha:(float)negativeAlpha delay:(float)delay{

    UIView *titleView = [[self.titlesArray objectAtIndex:chapterIndex] objectAtIndex:index];
    UILabel *titleLBL = (UILabel*)[titleView viewWithTag:1];

    [UIView animateWithDuration:0.2  delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
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
    
    [self performSegueWithIdentifier:@"JAArticlePush" sender:self];
    
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    int index = (int)(targetContentOffset->x / (self.view.frame.size.width/2));
    self.manager.currentChapter = index;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.titlesView.frame = CGRectMake(-scrollView.contentOffset.x * 2, self.titlesView.frame.origin.y, self.titlesView.frame.size.width, self.titlesView.frame.size.height);
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
}
-(BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)scrollRead:(float)percent{
    NSLog(@"Percent %f",percent);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
-(IBAction)returnFromArticleView:(UIStoryboardSegue*)segue{
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"JAArticlePush"]) {
        JAArticleCollectionViewController *articleController = segue.destinationViewController;
        [articleController setDelegate:self];

        articleController.oldPercentScroll = 10.0;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation*/



@end
