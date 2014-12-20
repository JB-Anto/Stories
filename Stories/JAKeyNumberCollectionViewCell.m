//
//  KeyNumberCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAKeyNumberCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JAKeyNumberCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint *numberLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *numberLabelCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *descriptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *descriptionLabelCenterYConstraint;

@property (nonatomic, strong) UIFont *numberFont;
@property (nonatomic, strong) UIColor *numberColor;
@property (nonatomic, strong) UIFont *descriptionFont;
@property (nonatomic, strong) UIColor *descriptionColor;

@end

@implementation JAKeyNumberCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
        
    // Main characteristics of labels in the view
    _numberFont   = [UIFont fontWithName:@"News-Plantin-Pro-Regular" size:82.5];
    _numberColor = [UIColor colorWithHue:0.08 saturation:0.74 brightness:0.93 alpha:1];
    _descriptionFont    = [UIFont fontWithName:@"Circular-Std-Book" size:24.0];
    _descriptionColor  = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:.9];
    
    // Creating subviews
    [self setupNumberLabel];
    [self setupDescriptionLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
    
}
     
- (void)setupNumberLabel
{
    
    _numberLabel = [JAUILabel new];
    [_numberLabel setNumberOfLines:0];
    [_numberLabel setFont:_numberFont];
    [_numberLabel setTextColor:_numberColor];
    
    [self.contentView addSubview:_numberLabel];
    
}
     
- (void)setupDescriptionLabel
{
    
    _descriptionLabel = [JAUILabel new];
    [_descriptionLabel setNumberOfLines:0];
    [_descriptionLabel setFont:_descriptionFont];
    [_descriptionLabel setTextColor:_descriptionColor];
    
    [self.contentView addSubview:_descriptionLabel];
    
}
     
- (void)setupConstraints
{
    
    self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal constraint
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.numberLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.numberLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    // Vertical constraint
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    self.descriptionLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.numberLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self.contentView addConstraint:self.descriptionLabelCenterYConstraint];
    
}

- (void)updateConstraints
{
    [super updateConstraints];
//    self.numberLabelHeightConstraint.constant = 2 * self.maxParallaxOffset;
    
}

- (void)setMaxParallaxOffset:(CGFloat)maxParallaxOffset
{
    _maxParallaxOffset = maxParallaxOffset;
    [self setNeedsUpdateConstraints];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    NSParameterAssert(layoutAttributes != nil);
    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
    
    ParallaxLayoutAttributes *parallaxLayoutAttributes = (ParallaxLayoutAttributes *)layoutAttributes;
    self.descriptionLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
    
}

@end
