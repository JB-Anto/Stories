//
//  JAFooterCollectionReusableView.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 20/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAFooterCollectionReusableView.h"
#import "ParallaxLayoutAttributes.h"

@interface JAFooterCollectionReusableView()

@property (nonatomic, strong) NSLayoutConstraint *backgroundImageViewCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *backgroundImageViewHeightConstraint;

@end

@implementation JAFooterCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
    
    [self setupBackgroundImageView];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    //    [self.backgroundImageView setBackgroundColor:[UIColor redColor]];
    
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
    
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    //    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
//
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.backgroundImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
//    
//    self.backgroundImageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
//    
//    self.backgroundImageViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backgroundImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//    
//    [self addConstraint:self.backgroundImageViewHeightConstraint];
//    [self addConstraint:self.backgroundImageViewCenterYConstraint];
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
