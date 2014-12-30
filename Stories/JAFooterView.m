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
    
    self.contentMode = UIViewContentModeBottom;
    self.initialCenter = self.center;
    
    return self;
    
}

-(void)animateEnterWithValue:(CGFloat)superViewHeight {
    [UIView animateWithDuration:1.5 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //NSLog(@"%.f", self.superview.superview.bounds.size.height);
        self.transform = CGAffineTransformMakeTranslation(0, superViewHeight-CGRectGetHeight(self.bounds)/2-125);
    } completion:nil];
}

@end
