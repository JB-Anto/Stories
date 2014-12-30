//
//  JACoverCollectionViewCell.h
//  Stories
//
//  Created by LANGLADE Antonin on 12/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAOrganicView.h"


@interface JACoverCollectionViewCell : UICollectionViewCell 

@property (strong, nonatomic) UIImageView *backgroundIV;
@property (strong, nonatomic) UIImageView *foregroundIV;
@property (strong, nonatomic) JAOrganicView *organicView;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UILabel *titleLBL;
@property (strong, nonatomic) UILabel *locationLBL;
@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) JAPlistManager *plistManager;

-(void)animateEnter;
-(void)resetAnimation;

@end
