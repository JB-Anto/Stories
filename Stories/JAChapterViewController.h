//
//  JAChapterViewController.h
//  Stories
//
//  Created by Antonin Langlade on 24/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAManagerData.h"
#import "JALoaderView.h"


@interface JAChapterViewController : UIViewController <LoaderDelegate>

@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) UIScrollView *chapterScrollView;
@property (strong, nonatomic) UIView *titlesView;
@property (strong, nonatomic) JALoaderView *loaderView;

@end
