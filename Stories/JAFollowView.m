
//
//  JAFollowView.m
//  Stories
//
//  Created by LANGLADE Antonin on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAFollowView.h"
@interface JAFollowView()

@property (strong,nonatomic) CAShapeLayer *maskWithHole;
@property (strong,nonatomic) CAShapeLayer *maskWithHole2;

@end

@implementation JAFollowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
        self.followView = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 160, 160)];
        
        
        self.maskWithHole = [CAShapeLayer layer];
        
        self.layer.transform = CATransform3DMakeRotation(45*M_PI/180, 0, 0, 1.0);
        
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        [maskPath moveToPoint:CGPointMake(0, 0)];
        [maskPath addLineToPoint:CGPointMake(frame.size.width, 0)];
        [maskPath addLineToPoint:CGPointMake(frame.size.width,frame.size.height)];
        [maskPath addLineToPoint:CGPointMake(0, frame.size.height)];
        [maskPath addLineToPoint:CGPointMake(0, 0)];
        [self.maskWithHole setPath:[maskPath CGPath]];
        self.maskWithHole.lineWidth = 10.0;
        [self.maskWithHole setFillColor:[UIColor clearColor].CGColor];
        [self.maskWithHole setStrokeColor:[[UIColor whiteColor] CGColor]];
        
        self.maskWithHole2 = [CAShapeLayer layer];
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPath];
        [maskPath2 moveToPoint:CGPointMake(0, 0)];
        [maskPath2 addLineToPoint:CGPointMake(frame.size.width, 0)];
        [maskPath2 addLineToPoint:CGPointMake(frame.size.width,frame.size.height)];
        [maskPath2 addLineToPoint:CGPointMake(0, frame.size.height)];
        [maskPath2 addLineToPoint:CGPointMake(0, 0)];
        [self.maskWithHole2 setPath:[maskPath2 CGPath]];

        [self.layer addSublayer:self.maskWithHole];
        [self.layer setMask:self.maskWithHole2];
        
    }
    
    return self;
    
}
-(void)rotateSquare:(float)angle{
    [UIView animateWithDuration:1.0 animations:^{
        self.layer.transform = CATransform3DMakeRotation(angle*M_PI/180, 0, 0, 1.0);
    }];
}

-(void)validateFollow{
    
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    
    animation.toValue = @(30.0);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [animation setDuration:.5];
    [self.maskWithHole addAnimation:animation forKey:@"tesst"];

}
-(void)unValidateFollow{
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    
    animation.toValue = @(10.0);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [animation setDuration:.5];
    [self.maskWithHole addAnimation:animation forKey:@"tesst"];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

}
@end


