//
//  JAOrganicView.m
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAOrganicView.h"

@implementation JAOrganicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {

        self.organicLayer = [CAShapeLayer layer];

        self.firstStepOrganic = [PocketSVG pathFromSVGFileNamed:@"forme1"];
        self.organicLayer.path = self.firstStepOrganic;
        
//        self.organicLayer.transform = CATransform3DMakeScale(1.17, 1.17, 1);
        
        [self.layer addSublayer:self.organicLayer];
//        [self animationPath];

    }
    return self;
    
}
-(void)animationPath{
    self.middleStepOrganic = [PocketSVG pathFromSVGFileNamed:@"forme2"];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
//    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 1.2;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.timingFunction = CreateCAMediaTimingFunction(0.19, 1, 0.22, 1);
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.fromValue = (__bridge id)(self.firstStepOrganic);
    pathAnimation.toValue = (__bridge id)(self.middleStepOrganic);

    [self.organicLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
}
-(void)finalAnimation:(void (^)())completion{
    self.endStepOrganic = [PocketSVG pathFromSVGFileNamed:@"forme3"];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 1.2;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.timingFunction = CreateCAMediaTimingFunction(0.19, 1, 0.22, 1);
    pathAnimation.fromValue = (__bridge id)(self.middleStepOrganic);
    pathAnimation.toValue = (__bridge id)(self.endStepOrganic);

    [self.organicLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
    

    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:completion
               afterDelay:1.0];
}
- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}
-(void)resetAnimation{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 0.1;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.timingFunction = CreateCAMediaTimingFunction(0.19, 1, 0.22, 1);
    pathAnimation.fromValue = (__bridge id)(self.middleStepOrganic);
    pathAnimation.toValue = (__bridge id)(self.firstStepOrganic);
    
    [self.organicLayer addAnimation:pathAnimation forKey:@"pathAnimation"];

}
-(void)setColor:(NSString *)color{
    [self.organicLayer setFillColor:[UIColor pxColorWithHexValue:color].CGColor];
}

@end
