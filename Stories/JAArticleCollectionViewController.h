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

@interface JAArticleCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSArray *blocks;
@property (strong, nonatomic) NSArray *credits;
@property (nonatomic,strong) JAManagerData *manager;
@property (nonatomic,strong) JABlockModel *currentBlock;
@property (nonatomic, strong) JACreditModel *creditBlock;
@property (strong, nonatomic) NSMutableArray *resumesID;
@end
