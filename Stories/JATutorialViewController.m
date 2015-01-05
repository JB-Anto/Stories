//
//  JATutorialViewController.m
//  Stories
//
//  Created by LANGLADE Antonin on 05/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import "JATutorialViewController.h"

@interface JATutorialViewController (){
    int sectionWidth;
    int sectionHeight;
}
@end

@implementation JATutorialViewController

-(id)initWithBlocks:(NSArray*)blocks delegate:(id)scrollDelegate{
    self = [super init];
    
    if(self)
    {
        self.blocks = blocks;

        self.scrollDelegate = scrollDelegate;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:@"myTestNotification" object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self delegateScroll];
        }];

    }
    
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    JATutorialPageViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}
- (JATutorialPageViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    JATutorialPageViewController *childViewController = [[JATutorialPageViewController alloc] init:[self.blocks objectAtIndex:index]];
    childViewController.index = index;
    
    return childViewController;
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(JATutorialPageViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(JATutorialPageViewController *)viewController index];
    
    
    index++;
    
    if (index == [self.blocks count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [self.blocks count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

-(void)delegateScroll{
    for (int i = 0; i<[self.blocks count]; i++) {
        if( self.scrollView.contentOffset.x ==  (float)self.view.frame.size.width * i ){
            for (int j = 0; j < self.pagerBar.circlePaginations.count; j++) {
                [[self.pagerBar.circlePaginations objectAtIndex:j] setFillColor:[[UIColor pxColorWithHexValue:@"41373c"]CGColor]];
            }
            [[self.pagerBar.circlePaginations objectAtIndex:i] setFillColor:[[UIColor whiteColor] CGColor]];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self delegateScroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
