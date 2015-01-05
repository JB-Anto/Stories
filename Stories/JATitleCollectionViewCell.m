//
//  TitleCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JATitleCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JATitleCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint *titleLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *locationLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *locationLabelCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *dateLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *dateLabelCenterYConstraint;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *infoFont;
@property (nonatomic, strong) UIColor *infoColor;

@end

@implementation JATitleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if(self == nil) {
        return nil;

    }
    
    self.manager = [JAManagerData sharedManager];
    
    // Main characteristics of labels in the view
    _titleFont = [UIFont fontWithName:@"Young-Serif-Regular" size:45.0];
    _infoFont = [UIFont fontWithName:@"Circular-Std-Medium" size:48.0];
    _titleColor = [self.manager getCurrentTextColor];
    _infoColor = [self.manager getCurrentColor];
    
    // Creating subviews
    [self setupLocationLabel];
    [self setupDateLabel];
    [self setupTitleLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
}

- (void)setupTitleLabel
{
    _titleLabel = [JAUILabel new];
    [_titleLabel setNumberOfLines:0];
    [_titleLabel setFont:_titleFont];
    [_titleLabel setTextColor:_titleColor];
    _titleLabel.lineHeight = 0.85;
    [_titleLabel setAlpha:0.85];
    
    [self.contentView addSubview:_titleLabel];
    
}

- (void)setupLocationLabel
{
    _locationLabel = [JAUILabel new];
    [_locationLabel setFont:_infoFont];
    [_locationLabel setTextColor:_infoColor];
    [_locationLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:_locationLabel];
    
}

- (void)setupDateLabel
{
    _dateLabel = [JAUILabel new];
    [_dateLabel setFont:_infoFont];
    [_dateLabel setTextColor:_infoColor];
    [_dateLabel setTextAlignment:NSTextAlignmentCenter];

    [self.contentView addSubview:_dateLabel];
    
}

- (void)setupConstraints
{
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal constraints
    // Title Label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    // Location Label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.locationLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    // Date Label
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    // Vertical constraints
    // Title Label
    self.titleLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.contentView addConstraint:self.titleLabelCenterYConstraint];
    // Location Label
    self.locationLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.locationLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.contentView addConstraint:self.locationLabelCenterYConstraint];
    // Date Label
    self.dateLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.locationLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.contentView addConstraint:self.dateLabelCenterYConstraint];

    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    NSParameterAssert(layoutAttributes != nil);
    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
    
    ParallaxLayoutAttributes *parallaxLayoutAttributes = (ParallaxLayoutAttributes *)layoutAttributes;    
    self.locationLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
    self.dateLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
    
}

@end
