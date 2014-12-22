//
//  JAInfoCollectionViewController.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 21/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAManagerData.h"
#import "JAStoriesModel.h"
#import "JAStorieModel.h"
#import "JAChapterModel.h"
#import "JAArticleModel.h"
#import "JABlockModel.h"
#import "JAFollowView.h"

@interface JAInfoCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, FollowDelegate>

@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) NSArray *blocks;
@property (strong, nonatomic) JAFollowView *followView;

@end
