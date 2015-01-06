//
//  JAContainerChapterScrollView.m
//  Stories
//
//  Created by LANGLADE Antonin on 06/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import "JAContainerChapterScrollView.h"

@implementation JAContainerChapterScrollView

- (id)initWithFrame:(CGRect)frame delegate:(id)scrollViewDelegate
{
    self = [super initWithFrame:frame];
    
    
    if(self)
    {
        self.clipsToBounds = YES;
        self.chapterScrollView = [[JAChapterScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, self.bounds.size.height)];
        self.chapterScrollView.delegate = scrollViewDelegate;
//        self.chapterScrollView.alpha = 0;
        [self addSubview:self.chapterScrollView];
    }
    
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [self pointInside:point withEvent:event] ? self.chapterScrollView : nil;
}

@end
