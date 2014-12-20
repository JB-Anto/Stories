//
//  JAHeaderCollectionReusableView.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 20/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAHeaderCollectionReusableView.h"
#import "ParallaxLayoutAttributes.h"

@interface JAHeaderCollectionReusableView()

@property (nonatomic, strong) NSLayoutConstraint *backgroundImageViewCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *backgroundImageViewHeightConstraint;

@end

@implementation JAHeaderCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
    
    [self setupBackgroundImageView];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
    
}

- (void)setupBackgroundImageView
{
    
    _backgroundImageView = [UIImageView new];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_backgroundImageView];
    
}

- (void)setupConstraints
{
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
}

//- (void)updateConstraints
//{
//    [super updateConstraints];
//    self.backgroundImageViewHeightConstraint.constant = 2 * self.maxParallaxOffset;
//}
//
//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    [super applyLayoutAttributes:layoutAttributes];
//    
//    NSParameterAssert(layoutAttributes != nil);
//    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
//    
//    ParallaxLayoutAttributes *parallaxLayoutAttributes = (ParallaxLayoutAttributes *)layoutAttributes;
//    NSLog(@"%f", parallaxLayoutAttributes.parallaxOffset.y);
//    self.backgroundImageViewCenterYConstraint.constant = -4*parallaxLayoutAttributes.parallaxOffset.y;
//    
//}

@end
