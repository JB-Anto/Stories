//
//  JAUILabel.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAUILabel : UILabel
-(void)setLineHeightWithNumber:(CGFloat)lineHeight;
-(void)setLineSpacingWithNumber:(CGFloat) lineSpacing;
-(CGRect)calculateRectInBoundingRectWithSize:(CGSize) maximumSize;
@end
