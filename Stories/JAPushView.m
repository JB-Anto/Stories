//
//  JAPushTextView.m
//  tacheExpand
//
//  Created by PENRATH Jean-baptiste on 08/01/2015.
//  Copyright (c) 2015 JB&Anto. All rights reserved.
//

#import "JAPushView.h"

@interface JAPushView() {
	BOOL expandMask;
    CGFloat screenHeight;
}

@end

@implementation JAPushView

@synthesize isAnimating;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self == nil) {
        return nil;
    }
    
    screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    [self setClipsToBounds:YES];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(-10, (CGRectGetHeight(frame)/2)-30, CGRectGetWidth(frame)+40, CGRectGetHeight(frame))];
    [self.textView setFont:[UIFont fontWithName:@"News-Plantin-Pro-Bold" size:45.0]];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setTextAlignment:NSTextAlignmentCenter];
    [self.textView setScrollEnabled:NO];
    [self.textView setEditable:NO];
    [self.textView setSelectable:NO];
    [self addSubview:self.textView];
    
    [self setupMasks];
    
    expandMask = NO;
    isAnimating = NO;
    
    //Gesture Recognizers
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(movePaths:)];
    pinchRecognizer.delegate = self;
    [self addGestureRecognizer:pinchRecognizer];
    
    [self setAlpha:0];
    
    return self;
    
}

-(void)setupMasks {
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.superview.bounds;
    
    //Mask Layers
    self.firstLayer = [CAShapeLayer layer];
    CGPathRef firstPath = [PocketSVG pathFromSVGFileNamed:@"top-zero"];
	[self.firstLayer setPosition:CGPointMake(0, 0)];
    self.firstLayer.path = firstPath;

    self.secondLayer = [CAShapeLayer layer];
    CGPathRef secondPath = [PocketSVG pathFromSVGFileNamed:@"bottom-zero"];
    self.secondLayer.path = secondPath;
	[self.secondLayer setPosition:CGPointMake(0, CGRectGetHeight(self.frame)/2)];
    
    self.thirdLayer = [CALayer layer];
    self.thirdLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)/2, CGRectGetWidth(self.frame), 1);
    [self.thirdLayer setBackgroundColor:[UIColor blackColor].CGColor];
    
    if(IS_IPHONE_6){
        self.firstLayer.transform = CATransform3DMakeScale(1.175, 1.175, 1);
        self.secondLayer.transform = CATransform3DMakeScale(1.175, 1.175, 1);
        self.thirdLayer.transform = CATransform3DMakeScale(1.175, 1.175, 1);
    }
    else if(IS_IPHONE_6P){
        self.firstLayer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
        self.secondLayer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
        self.thirdLayer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
    }
    
    [maskLayer addSublayer:self.firstLayer];
    [maskLayer addSublayer:self.secondLayer];
    [maskLayer addSublayer:self.thirdLayer];
    
    self.layer.mask = maskLayer;
}

-(void)movePaths:(UIPinchGestureRecognizer*)sender {
    if(isAnimating){
        return;
    }
    if(sender.scale < 1) {
        if(expandMask && CGRectGetHeight(self.thirdLayer.frame) < 30) {
            [self resetAnimation:^{
                expandMask = NO;
                [self removeAnimation:^{
                    isAnimating = NO;
                    [self removeFromSuperview];
                }];
            }];
            [self.firstLayer setPosition:CGPointMake(0,  0)];
            [self.secondLayer setPosition:CGPointMake(0, CGRectGetHeight(self.frame)/2)];
            self.thirdLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)/2, CGRectGetWidth(self.superview.bounds), 1);
            
        }
        else if(expandMask) {
            [self.firstLayer  setPosition:CGPointMake(0, self.firstLayer.frame.origin.y + 2.5)];
            [self.secondLayer setPosition:CGPointMake(0, self.secondLayer.frame.origin.y - 2.5)];
            [self.thirdLayer  setFrame:CGRectMake(0, self.thirdLayer.frame.origin.y + 2.5, CGRectGetWidth(self.thirdLayer.frame), CGRectGetHeight(self.thirdLayer.frame) - 5)];
            [self.textView setFrame:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y + 1, CGRectGetWidth(self.textView.bounds), CGRectGetHeight(self.textView.bounds) - 1)];
        }
    }
    
    if(sender.scale > 1) {
        if(!expandMask) {
            [self middleAnimation:^{
                expandMask = YES;
                isAnimating = NO;
            }];
        }
        else if(expandMask && CGRectGetHeight(self.thirdLayer.frame) <= CGRectGetHeight(self.frame)-200) {
            [self.firstLayer  setPosition:CGPointMake(0, self.firstLayer.frame.origin.y - 2.5)];
            [self.secondLayer setPosition:CGPointMake(0, self.secondLayer.frame.origin.y + 2.5)];
            [self.thirdLayer setFrame:CGRectMake(0, self.thirdLayer.frame.origin.y - 2.5 , CGRectGetWidth(self.thirdLayer.frame), CGRectGetHeight(self.thirdLayer.frame) + 5)];
            [self.textView setFrame:CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y - 1.5, CGRectGetWidth(self.textView.bounds), CGRectGetHeight(self.textView.bounds) + 1.5)];
        }
    }
    
    sender.scale = 1;
}

-(void)firstAnimation:(void (^)(void))block{
    isAnimating = YES;
    [CATransaction begin];{
        [CATransaction setCompletionBlock:^{
            block();
        }];
        
        CABasicAnimation *pathAnimation = [self switchBetweenPathA:@"top-zero" PathB:@"top-base" WithDuration:0.5];
        [self.firstLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        CABasicAnimation *pathAnimation2 = [self switchBetweenPathA:@"bottom-zero" PathB:@"bottom-base" WithDuration:0.5];
        [self.secondLayer addAnimation:pathAnimation2 forKey:@"pathAnimation"];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.9;
        }];
        
    }
    [CATransaction commit];
    
}

-(void)middleAnimation:(void (^)(void))block{
    isAnimating = YES;
    [CATransaction begin];{
        [CATransaction setCompletionBlock:^{
            block();
        }];
        
        CABasicAnimation *pathAnimation = [self switchBetweenPathA:@"top-base" PathB:@"top-expand" WithDuration:0.5];
        [self.firstLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        CABasicAnimation *pathAnimation2 = [self switchBetweenPathA:@"bottom-base" PathB:@"bottom-expand" WithDuration:0.5];
        [self.secondLayer addAnimation:pathAnimation2 forKey:@"pathAnimation"];
    }
    [CATransaction commit];
    
}

-(void)resetAnimation:(void (^)(void))block{
    isAnimating = YES;
    [CATransaction begin];{
        [CATransaction setCompletionBlock:^{
            block();
        }];
        
        CABasicAnimation *pathAnimation = [self switchBetweenPathA:@"top-expand" PathB:@"top-base" WithDuration:0.5];
        [self.firstLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        CABasicAnimation *pathAnimation2 = [self switchBetweenPathA:@"bottom-expand" PathB:@"bottom-base" WithDuration:0.5];
        [self.secondLayer addAnimation:pathAnimation2 forKey:@"pathAnimation"];
    }
    [CATransaction commit];
}

-(void)removeAnimation:(void (^)(void))block{
    isAnimating = YES;
    [CATransaction begin];{
        [CATransaction setCompletionBlock:^{
            block();
        }];
        
        CABasicAnimation *pathAnimation = [self switchBetweenPathA:@"top-base" PathB:@"top-zero" WithDuration:0.25];
        [self.firstLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        CABasicAnimation *pathAnimation2 = [self switchBetweenPathA:@"bottom-base" PathB:@"bottom-zero" WithDuration:0.25];
        [self.secondLayer addAnimation:pathAnimation2 forKey:@"pathAnimation"];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
        }];
        
    }
    [CATransaction commit];
}

- (CABasicAnimation *)switchBetweenPathA:(NSString *)pathA PathB:(NSString *)pathB WithDuration:(CGFloat)duration {
    CGPathRef beginShapePath = [PocketSVG pathFromSVGFileNamed:pathA];
    CGPathRef finalShapePath = [PocketSVG pathFromSVGFileNamed:pathB];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = duration;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.fromValue = (__bridge id)(beginShapePath);
    pathAnimation.toValue = (__bridge id)(finalShapePath);
    
    return pathAnimation;
}

@end
