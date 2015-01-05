//
//  CreditsCollectionViewCell.h
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAUILabel.h"

@interface JACreditCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) JAManagerData* manager;
@property (strong, nonatomic) JAUILabel *titleLabel;
@property (strong, nonatomic) JAUILabel *namesLabel;
@property (nonatomic) CGFloat maxParallaxOffset;

@end
