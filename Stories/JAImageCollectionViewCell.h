//
//  ImageCollectionViewCell.h
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAUILabel.h"

@interface JAImageCollectionViewCell : UICollectionViewCell <UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) JAUILabel *legendLabel;
@end
