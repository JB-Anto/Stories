//
//  ArticleCollectionViewController.h
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAStoriesModel.h"
#import "JAStorieModel.h"
#import "JAChapterModel.h"
#import "JABlockModel.h"
#import "JACreditModel.h"
#import "JAManagerData.h"
#import "JAFollowView.h"
#import "JAHeaderView.h"
#import "JAFooterView.h"
#import "JAUITextView.h"

@protocol ScrollRead

-(void)scrollRead:(float)percent;

@end

@interface JAArticleCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, FollowDelegate,UIGestureRecognizerDelegate, JAUITextViewDelegate>


@property (strong, nonatomic) NSArray *blocks;
@property (strong, nonatomic) NSArray *credits;
@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) JAFollowView *followView;
@property (strong, nonatomic) JAHeaderView *headerView;
@property (strong, nonatomic) JAFooterView *footerView;
@property (strong, nonatomic) UIImage *snapshot;
@property (nonatomic, assign) id delegate;
@property float oldPercentScroll;


@end





