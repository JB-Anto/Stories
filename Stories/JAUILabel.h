//
//  JAUILabel.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAUILabel : UILabel

@property CGFloat lineHeight;
@property CGFloat letterSpacing;

-(void)initWithString:(NSString *)text;
-(void)applyLineHeight;
-(void)applyLetterSpacing;

@end
