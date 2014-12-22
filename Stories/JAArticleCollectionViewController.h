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

@interface JAArticleCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, FollowDelegate>
@property (strong, nonatomic) NSArray *blocks;
@property (strong, nonatomic) NSArray *credits;
@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) JABlockModel *currentBlock;
@property (strong, nonatomic) JACreditModel *creditBlock;
@property (strong, nonatomic) NSMutableArray *resumesID;
@property (strong, nonatomic) JAFollowView *followView;
@end
