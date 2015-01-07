//
//  JACoverCollectionViewController.m
//  Stories
//
//  Created by LANGLADE Antonin on 12/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACoverCollectionViewController.h"

@interface JACoverCollectionViewController (){
    JATutorialViewController *tutorialVC;
}

@property UIGestureRecognizerState stateLongTap;
@property BOOL animatedLoader;
@property BOOL firstTime;

@end

@implementation JACoverCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [JAManagerData sharedManager];
    self.plistManager = [JAPlistManager sharedInstance];
    
    self.firstTime = YES;
    self.animatedLoader = NO;
    self.currentIndex = 0;
    self.stateLongTap = UIGestureRecognizerStatePossible;

    // Layout View
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds),  CGRectGetHeight(self.view.bounds));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    // Collection View
    self.collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = NO;
    self.collectionView.collectionViewLayout = layout;

    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[JACoverCollectionViewCell class] forCellWithReuseIdentifier:@"CoverCell"];
    self.collectionView.pagingEnabled = YES;

    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // Name View
    self.nameViewLBL = [[UILabel alloc]initWithFrame:CGRectMake(25, 25, self.view.bounds.size.width, 50)];
    self.nameViewLBL.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    self.nameViewLBL.font = [UIFont fontWithName:@"Circular-Std-Book" size:19.0];
    self.nameViewLBL.text = @"Publications";
    [self.view addSubview:self.nameViewLBL];
    
    self.followLBL = [[UILabel alloc]initWithFrame:CGRectMake(25, 30, self.view.bounds.size.width, 50)];
    self.followLBL.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    self.followLBL.font = [UIFont fontWithName:@"Circular-Std-Book" size:19.0];
    self.followLBL.text = @"Followed";
    self.followLBL.alpha = 0;
    [self.view addSubview:self.followLBL];

    
    // Loader View
    self.loaderView = [[JALoaderView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.loaderView.delegate = self;
    [self.view addSubview:self.loaderView];
    
    // Follow View
    self.followView = [[JAFollowView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 75, 35, 40, 40)];
    self.followView.delegate = self;
    self.followView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.followView];
    
    // Tuto View
//    if([[self.plistManager getTuto] isEqualToString:@"1"]){
//        [self.plistManager setTuto:@"0"];
//        NSArray *tutoArray = @[@{ @"title" : @"Swipe to discover more stories",
//                                  @"image" :  @"Swipe_000%i.png",
//                                  @"numberImage" : @100,
//                                  @"custom" :  @0},
//                               @{ @"title" : @"Hold to go learn more about something",
//                                  @"image" :  @"Hold_000%i.png",
//                                  @"numberImage" : @80,
//                                  @"custom" :  @0},
//                               @{ @"title" : @"Drag to follow a new story",
//                                  @"image" :  @"Drag_000%i.png",
//                                  @"numberImage" : @100,
//                                  @"custom" :  @0},
//                               @{ @"title" : @"Flip the phone to go back to the Home page at any moment",
//                                  @"image" :  @"Flip_000%i.png",
//                                  @"numberImage" : @98,
//                                  @"custom" :  @0,
//                                  @"button" :  @1}
//                               ];
//        
//        tutorialVC = [[JATutorialViewController alloc]initWithBlocks:tutoArray delegate:self];
//        [self.view addSubview:tutorialVC.view];
//        
//        tutorialVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
//        
//        [[NSNotificationCenter defaultCenter] addObserverForName:@"leaveTuto" object:nil queue:nil usingBlock:^(NSNotification *note) {
//            
//            [tutorialVC.view removeFromSuperview];
//            // Gesture recognizer
//            UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
//            longPressRecognizer.minimumPressDuration = .3;
//            longPressRecognizer.numberOfTouchesRequired = 1;
//            [self.view addGestureRecognizer:longPressRecognizer];
//        }];
//    }
//    else{
//        // Gesture recognizer
        UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressDetected:)];
        longPressRecognizer.minimumPressDuration = .3;
        longPressRecognizer.numberOfTouchesRequired = 1;
        [self.view addGestureRecognizer:longPressRecognizer];
//    }

   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self animateFollow];
    [self.followView fadeIn];
    [self reverseAnimation];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)longPressDetected:(UITapGestureRecognizer *)sender{
    
    CGPoint touchPosition = [sender locationInView:self.view];
    
    [self.loaderView movePosition:touchPosition];
    [self.loaderView setState:sender.state];

}
-(void)loadNextView{

    [self.followView fadeOut];
    JACoverCollectionViewCell *myCell = [[self.collectionView visibleCells] firstObject];
    [UIView animateWithDuration:.5 animations:^{
        myCell.titleView.frame = (CGRect){.origin=CGPointMake(myCell.titleView.frame.origin.x, myCell.titleView.frame.origin.y - 60),.size=myCell.titleView.frame.size};
    } completion:^(BOOL finished) {
        [myCell bringSubviewToFront:myCell.organicView];
        [UIView animateWithDuration:.7 animations:^{
            self.nameViewLBL.alpha = 0;
            myCell.titleView.alpha = 0;
        }];
        [myCell.organicView finalAnimation:^{
            [self performSegueWithIdentifier:@"JACoverPush" sender:self];
        }];
    }];
    self.manager.currentStorie = (int)self.currentIndex;

}
-(void)reverseAnimation{
    JACoverCollectionViewCell *myCell = [[self.collectionView visibleCells] firstObject];
    [myCell.organicView reverseAnimation:^{
        [UIView animateWithDuration:.5 animations:^{
            self.nameViewLBL.alpha = 1;
            myCell.titleView.alpha = 1;
            myCell.titleView.frame = (CGRect){.origin=CGPointMake(myCell.titleView.frame.origin.x, myCell.titleView.frame.origin.y + 60),.size=myCell.titleView.frame.size};
            [myCell.organicView removeFromSuperview];
            [myCell insertSubview:myCell.organicView aboveSubview:myCell.foregroundIV];
        }];
    }];
    
}
-(void)animateScrollView:(JAAnimDirection)direction{
    
    if((self.currentIndex >= 3 && direction == JAAnimDirectionLeft) || (self.currentIndex == 0 && direction == JAAnimDirectionRight)){
        return;
    }
    
    direction==JAAnimDirectionRight?self.currentIndex--:self.currentIndex++;

    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];

    [self.collectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JACoverCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"CoverCell"
                                    forIndexPath:indexPath];
    
    long row = [indexPath row];
    
    UIImage *background = [UIImage imageNamed:[[self.manager.data.stories[row] cover] background]];
    UIImage *foreground = [UIImage imageNamed:[[self.manager.data.stories[row] cover] foreground]];
    myCell.clipsToBounds = YES;

    myCell.backgroundIV.image = background;
    myCell.foregroundIV.image = foreground;
    myCell.titleLBL.text = [[self.manager.data.stories[row] cover] title];
    myCell.locationLBL.text = [[self.manager.data.stories[row] cover] location];
    [myCell.organicView setColor:[[self.manager.data.stories[row] cover] color]];
    [myCell.organicView setPaths:[[self.manager.data.stories[row] cover] paths]];
    
    return myCell;
}

-(void)followArticle:(BOOL)follow{

    [self.plistManager setValueForKey:@"follow" value:[NSNumber numberWithBool:follow] index:self.currentIndex];
    if(follow == YES){
        [UIView animateWithDuration:.3 animations:^{
            self.nameViewLBL.transform = CGAffineTransformMakeTranslation(0, -20);
            self.nameViewLBL.alpha = 0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:.4 animations:^{
                self.nameViewLBL.transform = CGAffineTransformMakeTranslation(0, 0);
                self.followLBL.alpha = 1;
                self.followLBL.transform =CGAffineTransformMakeTranslation(0, -5);
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:.3 delay:.5 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.followLBL.transform =CGAffineTransformMakeTranslation(0, -20);
                    self.followLBL.alpha = 0;
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:.4 animations:^{
                        self.followLBL.transform = CGAffineTransformMakeTranslation(0, 0);
                        self.nameViewLBL.transform = CGAffineTransformMakeTranslation(0, -5);
                        self.nameViewLBL.alpha = 1;
                    }];
                }];

            }];
        }];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.manager.data.stories count];
}

#pragma mark <UICollectionViewDelegate>
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        [self.cellToAnimate animateEnter];
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(JACoverCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    self.cellToAnimate = cell;

    if(self.firstTime){
        [cell animateEnter];
        [cell.organicView middleAnimation];
        [self animateFollow];
        self.firstTime = NO;

    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(JACoverCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [cell resetAnimation];
}
-(void)animateFollow{
    
    self.followView.validate = [[[self.plistManager getObject:@"follow"] objectAtIndex:self.currentIndex] boolValue];

    if([[self.plistManager getObject:@"follow"] objectAtIndex:self.currentIndex] == [NSNumber numberWithBool:true]){
        [self.followView animationBorder:JAAnimEntryIn];
    }
    else{
        [self.followView animationBorder:JAAnimEntryOut];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        self.currentIndex = (int)(scrollView.contentOffset.x/self.collectionView.frame.size.width);
        [self.cellToAnimate.organicView middleAnimation];
        [self animateFollow];
    }
    else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"myTestNotification" object:nil];
    }

}

-(IBAction)returnFromChapterView:(UIStoryboardSegue*)segue{

}
-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
