//
//  ResumeCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAResumeCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JAResumeCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint *resumeLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *resumeLabelCenterYConstraint;

@property (nonatomic, strong) UIFont *resumeFont;
@property (nonatomic, strong) UIColor *resumeColor;

@end

@implementation JAResumeCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }

    // Main characteristics of labels in the view
    _resumeFont = [UIFont fontWithName:@"Circular-Std-Book" size:12.0];
    _resumeColor = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:1];
    
    // Creating subviews
    [self setupResumeLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
}

-(void)setupResumeLabel
{
    
    _resumeLabel = [JAUILabel new];
    [_resumeLabel setNumberOfLines:2];
    [_resumeLabel setFont:_resumeFont];
    [_resumeLabel setTextColor:_resumeColor];
    _resumeLabel.lineHeight = 1.2;
    [self.contentView addSubview:_resumeLabel];
    
}

-(void)setupConstraints
{
    
    self.resumeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.resumeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0]];
    
    self.resumeLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.resumeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];

    [self.contentView addConstraint:self.resumeLabelCenterYConstraint];
    
}

- (void)updateConstraints
{
    [super updateConstraints];
    self.resumeLabelHeightConstraint.constant = 2 * self.maxParallaxOffset;
}

//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    [super applyLayoutAttributes:layoutAttributes];
//    NSParameterAssert(layoutAttributes != nil);
//    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
//    ParallaxLayoutAttributes *parallaxLayoutAttributes = (ParallaxLayoutAttributes *)layoutAttributes;
//    self.resumeLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
//    
//}

@end
