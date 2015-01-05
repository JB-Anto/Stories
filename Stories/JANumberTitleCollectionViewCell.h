//
//  JANumberTitleCollectionViewCell.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 22/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAUILabel.h"

@interface JANumberTitleCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) JAManagerData* manager;
@property (strong, nonatomic) JAUILabel *numberLabel;
@property (strong, nonatomic) JAUILabel *textLabel;
@property (nonatomic) CGFloat maxParallaxOffset;

@end
