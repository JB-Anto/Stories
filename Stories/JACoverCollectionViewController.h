//
//  JACoverCollectionViewController.h
//  Stories
//
//  Created by LANGLADE Antonin on 12/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JACoverCollectionViewCell.h"
#import "JALoaderView.h"
#import "JAManagerData.h"
#import "JAStoriesModel.h"
#import "JAStorieModel.h"

typedef NS_ENUM(NSInteger, JAAnimDirection) {
    JAAnimDirectionLeft,
    JAAnimDirectionRight
};

@interface JACoverCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, LoaderDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) JACoverCollectionViewCell *cellToAnimate;
@property (nonatomic,strong) JAManagerData *manager;
@property (strong, nonatomic) JALoaderView *loaderView;
@property (strong, nonatomic) UILabel *nameViewLBL;
@property int currentIndex;
@end
