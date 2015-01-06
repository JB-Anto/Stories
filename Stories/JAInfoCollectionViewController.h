//
//  JAInfoCollectionViewController.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 21/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAStoriesModel.h"
#import "JAStorieModel.h"
#import "JAChapterModel.h"
#import "JAArticleModel.h"
#import "JABlockModel.h"
#import "JAFollowView.h"
#import "JAHeaderView.h"
#import "JAFooterView.h"

@interface JAInfoCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, FollowDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) JAPlistManager *plistManager;
@property (strong, nonatomic) NSArray *blocks;
@property (strong, nonatomic) JAFollowView *followView;
@property (strong, nonatomic) JAHeaderView *headerView;
@property (strong, nonatomic) JAFooterView *footerView;
@property (strong, nonatomic) UIImage *snapshot;

@end
