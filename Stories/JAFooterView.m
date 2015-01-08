//
//  JAFooterCollectionReusableView.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 20/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAFooterView.h"

@implementation JAFooterView

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
//        self.transform = CGAffineTransformMakeTranslation(0, superViewHeight-CGRectGetHeight(self.bounds)/2-self.frame.origin.y-50);
        self.transform = CGAffineTransformMakeTranslation(0, superViewHeight);
    } completion:nil];
}

@end
