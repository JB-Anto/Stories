//
//  MainViewController.h
//  Stories
//
//  Created by Antonin Langlade on 10/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JACoverContentViewController.h"
#import "JSONFetcher.h"




@interface JAMainViewController : UIViewController <SwitchCoverProtocol, UIPageViewControllerDataSource>



- (void)setViewControllers:(NSArray *)viewControllers
                 direction:(UIPageViewControllerNavigationDirection)direction
                  animated:(BOOL)animated
                completion:(void (^)(BOOL finished))completion;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *coverModel;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *viewControllers;

@end


