//
//  JAPortraitTitleCollectionViewCell.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 22/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAUILabel.h"

@interface JAPortraitTitleCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) JAManagerData* manager;
@property (strong, nonatomic) UIImageView *portraitImageView;
@property (strong, nonatomic) JAUILabel *nameLabel;
@property (strong, nonatomic) JAUILabel *portraitLabel;
@property (nonatomic) CGFloat maxParallaxOffset;

@end
