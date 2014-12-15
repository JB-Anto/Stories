//
//  QuotesCollectionViewCell.h
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAUILabel.h"
#import "JAUITextView.h"

@interface JAQuotesCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) JAUILabel *quoteLabel;
@property (strong, nonatomic) JAUILabel *authorLabel;
@property (nonatomic) CGFloat maxParallaxOffset;

@end
