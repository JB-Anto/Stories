//
//  JAUILabel.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface JAUILabel : UILabel
-(void)setLineHeightWithNumber:(CGFloat)lineHeight;
-(void)setLineSpacingWithNumber:(CGFloat) lineSpacing;
-(CGRect)calculateRectInBoundingRectWithSize:(CGSize) maximumSize;
-(CGRect)calculateRectInBoundingRectWithSize:(CGSize) maximumSize AndLineHeight:(CGFloat)lineHeight;
@end
