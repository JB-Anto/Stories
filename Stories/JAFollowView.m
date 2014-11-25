
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
@property CGPoint centerView;
@property BOOL validate;

@end

@implementation JAFollowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {

        self.maskWithHole = [CAShapeLayer layer];
        self.centerView = self.center;
        self.validate = NO;
        
        self.layer.transform = CATransform3DMakeRotation(45*M_PI/180, 0, 0, 1.0);
        
        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        [maskPath moveToPoint:CGPointMake(frame.size.width/4, frame.size.height/4)];
        [maskPath addLineToPoint:CGPointMake(frame.size.width * 3/4, frame.size.height/4)];
        [maskPath addLineToPoint:CGPointMake(frame.size.width * 3/4,frame.size.height * 3/4)];
        [maskPath addLineToPoint:CGPointMake(frame.size.width/4, frame.size.height * 3/4)];
        [maskPath addLineToPoint:CGPointMake(frame.size.width/4, frame.size.height / 4)];
        [self.maskWithHole setPath:[maskPath CGPath]];
        self.maskWithHole.lineWidth = 8.0;
        [self.maskWithHole setFillColor:[UIColor clearColor].CGColor];
        [self.maskWithHole setStrokeColor:[[UIColor whiteColor] CGColor]];
        
        self.maskWithHole2 = [CAShapeLayer layer];
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPath];
        [maskPath2 moveToPoint:CGPointMake(frame.size.width/4, frame.size.height/4)];
        [maskPath2 addLineToPoint:CGPointMake(frame.size.width * 3/4, frame.size.height/4)];
        [maskPath2 addLineToPoint:CGPointMake(frame.size.width * 3/4,frame.size.height * 3/4)];
        [maskPath2 addLineToPoint:CGPointMake(frame.size.width/4, frame.size.height * 3/4)];
        [maskPath2 addLineToPoint:CGPointMake(frame.size.width/4, frame.size.height/4)];
        [self.maskWithHole2 setPath:[maskPath2 CGPath]];
        [self.layer addSublayer:self.maskWithHole];
        [self.layer setMask:self.maskWithHole2];
        
        UILongPressGestureRecognizer *dragFollow = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(followDrag:)];
        dragFollow.minimumPressDuration = .01;
        dragFollow.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:dragFollow];
        
    }
    return self;
    
}

-(void)rotateSquare:(float)angle{
    [UIView animateWithDuration:1.0 animations:^{
        self.layer.transform = CATransform3DMakeRotation(angle*M_PI/180, 0, 0, 1.0);
    }];
}
-(void)followDrag:(UITapGestureRecognizer *)sender{
    CGPoint touchPosition = [sender locationInView:self.superview];
    float degree = [self getAngleFromMouse:touchPosition] * 180 / M_PI;
    float distance = [self getDistanceFromMouse:touchPosition];
    

    if(sender.state == UIGestureRecognizerStateChanged) {
        if(degree > 90 && degree < 180){
            self.center = touchPosition;
        }
        if (distance >= 90) {
            [self validateFollow];
        }
        else{
            [self unValidateFollow];
        }
    }
    else if(sender.state == UIGestureRecognizerStateEnded){
        [self animateToCenter];
    }
//    NSLog(@"Angle %f || Distance %f", degree, distance);
}
-(void)validateFollow{
    if(self.validate == NO){
        [self animationBorder:JAAnimEntryIn];
        [self.delegate followArticle:YES];
    }
    self.validate = YES;
}
-(void)unValidateFollow{
    if(self.validate == YES){
        [self animationBorder:JAAnimEntryOut];
        [self.delegate followArticle:NO];
    }
    self.validate = NO;
}
-(void)animationBorder:(JAAnimationEntry)entry{
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation.fromValue = entry==JAAnimEntryIn?@(8.0f):@(30.0f);
    animation.toValue = entry==JAAnimEntryIn?@(30.0f):@(8.0f);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [animation setDuration:.5];
    [self.maskWithHole addAnimation:animation forKey:@"tesst"];
}


-(float)getAngleFromMouse:(CGPoint)touchPosition{
    return atan2(( touchPosition.y - self.centerView.y), (touchPosition.x - self.centerView.x));
};

-(float)getDistanceFromMouse:(CGPoint)touchPosition{
    return sqrt(pow((touchPosition.x - self.centerView.x),2)+pow((touchPosition.y - self.centerView.y),2));
};

-(void)animateToCenter{
    [UIView animateWithDuration:.2 animations:^{
        self.center = self.centerView;
    }];
}

@end


