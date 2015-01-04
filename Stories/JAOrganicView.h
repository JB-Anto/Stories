//
//  JAOrganicView.h
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PocketSVG.h"

@interface JAOrganicView : UIView

@property (strong, nonatomic) UIView *organicView;
@property (strong, nonatomic) CAShapeLayer *organicLayer;
@property (strong, nonatomic) NSArray *paths;

@property CGPathRef firstStepOrganic;
@property CGPathRef middleStepOrganic;
@property CGPathRef endStepOrganic;

- (id)initWithFrame:(CGRect)frame paths:(NSArray*)paths;
-(void)middleAnimation;
-(void)finalAnimation:(void(^)())completion;
-(void)resetAnimation;
-(void)setColor:(NSString*)color;


@end
