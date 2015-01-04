//
//  JAOrganicView.m
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAOrganicView.h"

@implementation JAOrganicView

- (id)initWithFrame:(CGRect)frame paths:(NSArray*)paths
{
    self = [super initWithFrame:frame];
    
    if(self)
    {

//        self.paths = paths;
        self.organicLayer = [CAShapeLayer layer];
        
        self.firstStepOrganic = [PocketSVG pathFromSVGFileNamed:[self.paths objectAtIndex:0]];
        self.middleStepOrganic = [PocketSVG pathFromSVGFileNamed:[self.paths objectAtIndex:1]];
        self.endStepOrganic = [PocketSVG pathFromSVGFileNamed:[self.paths objectAtIndex:2]];
        
        NSLog(@"Pathssss %@",self.paths);
        
        self.organicLayer.path = self.firstStepOrganic;
        
        if(IS_IPHONE_6){
            self.organicLayer.transform = CATransform3DMakeScale(1.175, 1.175, 1);
        }
        else if(IS_IPHONE_6P){
            self.organicLayer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
        }
        
        [self.layer addSublayer:self.organicLayer];

    }
    return self;
    
}

-(void)middleAnimation{

    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 1.2;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.timingFunction = CreateCAMediaTimingFunction(0.19, 1, 0.22, 1);
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.fromValue = (__bridge id)(self.firstStepOrganic);
    pathAnimation.toValue = (__bridge id)(self.middleStepOrganic);
    
    [self.organicLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
}
-(void)finalAnimation:(void (^)())completion{


    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 1.2;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.timingFunction = CreateCAMediaTimingFunction(0.19, 1, 0.22, 1);
    pathAnimation.fromValue = (__bridge id)(self.middleStepOrganic);
    pathAnimation.toValue = (__bridge id)(self.endStepOrganic);

    [self.organicLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
    

    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:completion
               afterDelay:1.2];
}
- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}
-(void)resetAnimation{

    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
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
