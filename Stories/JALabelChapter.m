//
//  JALabelChapter.m
//  Stories
//
//  Created by LANGLADE Antonin on 06/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import "JALabelChapter.h"

@implementation JALabelChapter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 20, 0, 20};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
