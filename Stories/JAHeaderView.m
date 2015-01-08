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
    
    self.initialCenter = self.center;
    
    return self;
    
}

-(void)animateEnterWithValue:(CGFloat)superViewHeight {
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.superview setUserInteractionEnabled:NO];
//        self.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.bounds)/2-self.frame.origin.y+110);
        self.transform = CGAffineTransformMakeTranslation(0, superViewHeight);
    } completion:^(BOOL finished) {
        [self.superview setUserInteractionEnabled:YES];
    }];
}

@end
