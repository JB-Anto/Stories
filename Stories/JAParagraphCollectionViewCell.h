//
//  ParagraphCollectionViewCell.h
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAUILabel.h"
#import "JAUITextView.h"

@interface JAParagraphCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) JAUITextView *paragraphLabel;
@property (nonatomic) CGFloat maxParallaxOffset;

@end
