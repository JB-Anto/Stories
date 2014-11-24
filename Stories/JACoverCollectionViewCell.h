//
//  JACoverCollectionViewCell.h
//  Stories
//
//  Created by LANGLADE Antonin on 12/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAFollowView.h"

@interface JACoverCollectionViewCell : UICollectionViewCell <FollowDelegate>

@property (strong, nonatomic) UIImageView *backgroundIV;
@property (strong, nonatomic) UIImageView *foregroundIV;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UILabel *titleLBL;
@property (strong, nonatomic) UILabel *locationLBL;
@property (strong, nonatomic) JAFollowView *followView;

-(void)animateEnter;
-(void)resetAnimation;

@end
