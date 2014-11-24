//
//  JAChapterViewController.m
//  Stories
//
//  Created by Antonin Langlade on 24/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAChapterViewController.h"

@interface JAChapterViewController ()

@property (strong, nonatomic) NSMutableArray *titlesArray;
@property (strong, nonatomic) NSDateFormatter *dateFormater;
@property (strong, nonatomic) NSDateFormatter *dateFormaterFromString;
@property NSUInteger chaptersCount;
@property float chapterHeight;
@property int currentIndex;
@property NSTimer *timerForLoader;
@end

@implementation JAChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [JAManagerData sharedManager];
    self.manager.currentStorie = 0;
    self.manager.currentChapter = 0;
    self.titlesArray = [NSMutableArray array];
    self.currentIndex = -1;
    
    // Date out format
    self.dateFormater = [[NSDateFormatter alloc]init];
    [self.dateFormater setDateFormat:@"MMM,\u00A0dd"];

    // Date in format
    self.dateFormaterFromString = [[NSDateFormatter alloc]init];
    [self.dateFormaterFromString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    // Get data
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"stories" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // Manager
    self.manager.data = [[JAStoriesModel alloc] initWithString:jsonString error:nil];
    
    // Chapters View
    self.chapterScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/7)];
    self.chapterScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.chapterScrollView];
    
    // Titles View
    self.titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/7, self.view.bounds.size.width, self.view.bounds.size.height*6/7)];
    self.titlesView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.titlesView];
    
    // Loader View
    self.loaderView = [[JALoaderView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.loaderView.delegate = self;
    [self.view addSubview:self.loaderView];

    // Gesture recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
    longPressRecognizer.minimumPressDuration = .05;
    longPressRecognizer.numberOfTouchesRequired = 1;
    [self.titlesView addGestureRecognizer:longPressRecognizer];
    
    // Count for Title View
    self.chaptersCount = [[[[self.manager.data.stories[self.manager.currentStorie] chapters] objectAtIndex:self.manager.currentChapter] articles] count];
    self.chapterHeight = self.titlesView.frame.size.height / self.chaptersCount;
    
    // Instanciate all titles
    
    for (int i = 0; i < self.chaptersCount ; i++) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, i*self.chapterHeight, self.view.frame.size.width, self.chapterHeight)];
        titleView.backgroundColor = [UIColor colorWithRed:1.0/self.chaptersCount *i green:1.0/self.chaptersCount *i blue: 1.0/self.chaptersCount*i alpha:1];
        
        NSString *text = [[[[[self.manager.data.stories[self.manager.currentStorie] chapters] objectAtIndex:self.manager.currentChapter] articles] objectAtIndex:i] title];
        
        NSString *dateString = [[[[[self.manager.data.stories[self.manager.currentStorie] chapters] objectAtIndex:self.manager.currentChapter] articles] objectAtIndex:i] createdAt];
    
        NSDate *date = [self.dateFormaterFromString dateFromString:dateString];
        NSString *finalDate = [self.dateFormater stringFromDate:date];
        
        NSMutableAttributedString * completeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",text,[finalDate lowercaseString]]];
        [completeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"News-Plantin-Pro-Regular" size:30.0] range:NSMakeRange(0,[text length])];
        [completeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Calibre-Thin" size:18.0] range:NSMakeRange([text length]+1,[finalDate length])];
        
        [completeString addAttribute:NSBaselineOffsetAttributeName value:@(10) range:NSMakeRange([text length]+1,[finalDate length])];
        
        UILabel *titleLBL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, titleView.frame.size.width - 40, titleView.frame.size.height)];
        titleLBL.lineBreakMode = NSLineBreakByWordWrapping;
        titleLBL.numberOfLines = 0;
        titleLBL.backgroundColor = [UIColor blueColor];
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
-(void)longPressDetected:(UITapGestureRecognizer *)sender{
    
    CGPoint touchPosition = [sender locationInView:self.titlesView];
    
    bool loadedNextView = NO;
    int index = (int)(touchPosition.y/self.chapterHeight);

    [self animateTitlesView:index negativeScale:0.0 negativeAlpha:0.0];
    
    if(self.currentIndex != index){
        NSLog(@"index %i %i",self.currentIndex,index);
        self.currentIndex = index;
        if(self.timerForLoader){
            [self.timerForLoader invalidate];
        }
        
        self.timerForLoader = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                               target:self
                                                             selector:@selector(startLoader)
                                                             userInfo:nil
                                                              repeats:NO];
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
            self.currentIndex = -1;
            for (int i = 0; i < [self.titlesArray count]; i++) {
                [self animateTitlesView:i negativeScale:.2 negativeAlpha:0.0];
            }
        }

    }
}
// Animate with a negatie scale and alpha value
-(void)animateTitlesView:(int)index negativeScale:(float)negativeScale negativeAlpha:(float)negativeAlpha{
    UIView *titleView = [self.titlesArray objectAtIndex:index];
    UILabel *titleLBL = (UILabel*)[titleView viewWithTag:1];
    [UIView animateWithDuration:0.2 animations:^{
        titleLBL.transform = CGAffineTransformMakeScale(1.0 - negativeScale, 1.0 - negativeScale);
        titleLBL.alpha = 1.0 - negativeAlpha;
    }];

}
-(void)startLoader{
    NSLog(@"Start Loader");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)prefersStatusBarHidden {
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
