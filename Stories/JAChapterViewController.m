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
    self.plistManager = [JAPlistManager sharedInstance];
    
    self.titlesArray = [NSMutableArray array];

    self.heightCellArray = [NSMutableArray array];
    self.currentIndex = -1;
    self.touchToLoad = NO;
    self.manager.currentChapter = 0;
    self.currentTranslation = 0;
    

    NSUInteger chaptersCount = [[[self.manager getCurrentStorie] chapters] count];
    
    self.view.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
    
    // Chapters View
    self.containerChapterScrollView = [[JAContainerChapterScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height/7) delegate:self];
    [self.view addSubview:self.containerChapterScrollView];
    
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
//    NSUInteger chaptersCount = [[[self.manager getCurrentStorie] chapters] count];
    
//    for(UIView *subview in [self.titlesView subviews]) {
//        if([subview isKindOfClass:[UIView class]]) {
//            [subview removeFromSuperview];
//        }
//    }
//    [self.titlesArray removeAllObjects];
//    for (int i = 0; i < chaptersCount; i++) {
//        [self.titlesView addSubview:[self createTitlesBlocks:i]];
//    }
    [self setOpacityChapters:self.containerChapterScrollView.chapterScrollView];
    [self updatePercentChapters];
    
    [UIView animateWithDuration:.5 animations:^{
        self.containerChapterScrollView.alpha = 1;
    }];

    for (int j = 0; j < [[[self.manager getCurrentStorie] chapters] count]; j++) {

        for (int i = 0; i < [[self.titlesArray objectAtIndex:j] count] ; i++) {
            [self animateTitlesView:i forChapter:j negativeScale:.2 negativeAlpha:.3 delay:i * .05];
        }
    }
    
}
-(void)updatePercentChapters{
    for (int i = 0; i < [self.titlesArray count]; i++) {
        for (int k = 0; k < [[self.titlesArray objectAtIndex:i] count]; k++) {
            JAChapterView *chapterView = [[self.titlesArray objectAtIndex:i] objectAtIndex:k];
            float percent = [[self.plistManager getPercentRead:i article:k] floatValue]*100;
            [chapterView updatePercent:percent];
        }
    }
}
-(UIView*)createTitlesBlocks:(int)index{
    // Count for Title View
    self.titleChapterCount = [[[[[self.manager getCurrentStorie] chapters] objectAtIndex:index] articles] count];
    float chapterHeight = self.titlesView.frame.size.height / self.titleChapterCount;
    
    [self.heightCellArray addObject:[NSNumber numberWithFloat:chapterHeight]];
    
    // Instanciate all titles
    UIView *globalTitleBlock = [[UIView alloc]initWithFrame:CGRectMake(index * self.view.frame.size.width, 0, self.view.frame.size.width, self.titlesView.frame.size.height)];
    NSMutableArray *arrayOfTitle = [NSMutableArray array];
    for (int i = 0; i < self.titleChapterCount ; i++) {
        
        float percent = [[self.plistManager getPercentRead:index article:i] floatValue]*100;
        
        JAChapterView *chapterView = [[JAChapterView alloc] initWithFrame:CGRectMake(0, i * chapterHeight, self.view.frame.size.width, chapterHeight) blocks:[[[[[self.manager getCurrentStorie] chapters]objectAtIndex:index] articles] objectAtIndex:i] percent:percent];
        
        [globalTitleBlock addSubview:chapterView];
        
        [arrayOfTitle addObject:chapterView];
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
//        NSLog(@"index %i %i",self.currentIndex,index);
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
//    NSLog(@"Start Loader");
    self.touchToLoad = YES;
    [self.loaderView movePosition:self.positionLoader];
    [self.loaderView setState:UIGestureRecognizerStateBegan];
    
}
-(void)loadNextView{
    [self performSegueWithIdentifier:@"JAArticlePush" sender:self];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    int index = (int)(targetContentOffset->x / (self.view.frame.size.width/2));
    self.manager.currentChapter = index;
    
}
-(void)scrollViewDidScroll:(JAChapterScrollView *)scrollView{
    
    [self setOpacityChapters:scrollView];
    self.titlesView.frame = CGRectMake(-scrollView.contentOffset.x * 2 , self.titlesView.frame.origin.y, self.titlesView.frame.size.width, self.titlesView.frame.size.height);
}
-(void)setOpacityChapters:(JAChapterScrollView*)scrollView{
    for (UILabel *label in scrollView.chapterArray ) {
        float x = (CGRectGetMinX(label.frame) - scrollView.contentOffset.x)/ scrollView.frame.size.width;
        float alpha = .66 + cos(M_PI * x)/3;
        if (x > -1 && x < 1 ) {
            label.alpha = alpha;
        } else {
            label.alpha = .5;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)scrollRead:(float)percent indexArticle:(int)index{

//    NSLog(@"Percent %f index %i",percent,index);
    NSNumber *percentNumber = [NSNumber numberWithFloat:percent];
    [self.plistManager setPercentRead:percentNumber storie:self.manager.currentStorie chapter:self.manager.currentChapter article:index];
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
//        NSLog(@"TESTTT %@",[self.plistManager getPercentRead]);
        articleController.oldPercentScroll = [[self.plistManager getPercentRead] floatValue];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation*/



@end
