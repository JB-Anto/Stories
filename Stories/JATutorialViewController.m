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

//-(id)init:(NSArray*)blocks{
//    self = [super init];
//    
//    if(self)
//    {
//        self.blocks = [NSArray arrayWithArray:blocks];
//    }
//    
//    return self;
//}
-(id)initWithBlocks:(NSArray*)blocks delegate:(id<UIScrollViewDelegate>)scrollDelegate{
    self = [super init];
    
    if(self)
    {
        self.blocks = blocks;
//        NSLog(@"blocks %@",blocks);
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

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake([self.blocks count] * self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.delegate = self.scrollDelegate;
    
    for (int i = 0; i < [self.blocks count]; i++) {
        JATutorialPageViewController *page = [[JATutorialPageViewController alloc] init:[self.blocks objectAtIndex:i]];
        [page.view setFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.scrollView addSubview:page.view];
    }
    
    sectionWidth = 30;
    sectionHeight = 30;
    
    self.pagerBar = [[JAPagerBar alloc] initWithNbSection:(int)[self.blocks count] sectionWidth:sectionWidth sectionHeight:sectionHeight];
    self.pagerBar.backgroundColor = [UIColor redColor];
    [self.pagerBar setFrame:CGRectMake(self.view.frame.size.width /2 - [self.blocks count] * sectionWidth / 2, self.view.bounds.size.height - 100, self.pagerBar.frame.size.width, self.pagerBar.frame.size.height)];
    [self.view addSubview:self.pagerBar];


    
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
