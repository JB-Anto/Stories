//
//  JATutorialViewController.h
//  Stories
//
//  Created by LANGLADE Antonin on 05/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAPagerBar.h"
#import "JATutorialPageViewController.h"

@interface JATutorialViewController : UIViewController

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *blocks;
@property (strong, nonatomic) JAPagerBar *pagerBar;
@property (strong, nonatomic) id<UIScrollViewDelegate> scrollDelegate;

-(id)initWithBlocks:(NSArray*)blocks delegate:(id<UIScrollViewDelegate>)scrollDelegate;

@end
