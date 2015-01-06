//
//  JAHeaderCollectionReusableView.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 20/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAHeaderView.h"

@implementation JAHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
    
    self.contentMode = UIViewContentModeTop;
    self.initialCenter = self.center;
    
    return self;
    
}

-(void)animateEnter{
    [UIView animateWithDuration:1 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.bounds)/2-self.frame.origin.y+110);
//        self.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.bounds)/2-self.frame.origin.y/2-50);
    } completion:nil];
}

@end
