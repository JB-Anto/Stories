//
//  JAPushTextView.h
//  tacheExpand
//
//  Created by PENRATH Jean-baptiste on 08/01/2015.
//  Copyright (c) 2015 JB&Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PocketSVG.h"

@interface JAPushView : UIView <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) CAShapeLayer *firstLayer;
@property (strong, nonatomic) CAShapeLayer *secondLayer;
@property (strong, nonatomic) CALayer *thirdLayer;
@property BOOL isAnimating;

-(void)firstAnimation:(void (^)(void))block;
-(void)resetAnimation:(void (^)(void))block;
-(void)removeAnimation:(void (^)(void))block;
@end
