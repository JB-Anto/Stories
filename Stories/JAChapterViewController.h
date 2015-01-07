//
//  JAChapterViewController.h
//  Stories
//
//  Created by Antonin Langlade on 24/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JALoaderView.h"
#import "JAChapterScrollView.h"
#import "JAArticleCollectionViewController.h"
#import "JAContainerChapterScrollView.h"
#import "JAChapterView.h"

@interface JAChapterViewController : UIViewController <LoaderDelegate, UIScrollViewDelegate, ScrollRead>

@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) JAPlistManager *plistManager;
@property (strong, nonatomic) JAContainerChapterScrollView *containerChapterScrollView;
@property (strong, nonatomic) UIView *titlesView;
@property (strong, nonatomic) JALoaderView *loaderView;

@end
