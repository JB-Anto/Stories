//
//  JAPortraitTitleCollectionViewCell.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 22/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAPortraitTitleCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JAPortraitTitleCollectionViewCell()

@property (strong, nonatomic) NSLayoutConstraint *nameLabelCenterYConstraint;
@property (strong, nonatomic) NSLayoutConstraint *portraitLabelCenterYConstraint;

@property (strong, nonatomic) UIFont *nameFont;
@property (strong, nonatomic) UIColor *nameColor;
@property (strong, nonatomic) UIFont *portraitFont;
@property (strong, nonatomic) UIColor *portraitColor;

@end


@implementation JAPortraitTitleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self == nil) {
        return nil;
    }
    
    self.manager = [JAManagerData sharedManager];
    
    _nameFont = [UIFont fontWithName:@"Young-Serif-Regular" size:45.0];
    _portraitFont = [UIFont fontWithName:@"Calibre-Regular" size:38.0];
    _nameColor = [self.manager getCurrentTextColor];
    _portraitColor = [self.manager getCurrentColor];
    
    [self setupPortraitImageView];
    [self setupPortraitLabel];
    [self setupNameLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
    
}

- (void)setupPortraitImageView {
    
    _portraitImageView = [UIImageView new];
    [_portraitImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.contentView addSubview:_portraitImageView];
    
}

- (void)setupPortraitLabel {
    
    _portraitLabel = [JAUILabel new];
    [_portraitLabel setText:@"Portrait"];
    [_portraitLabel setFont:_portraitFont];
    [_portraitLabel setTextColor:_portraitColor];
    [_portraitLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_portraitLabel];
    
}

- (void)setupNameLabel {
    
    _nameLabel = [JAUILabel new];
    [_nameLabel setFont:_nameFont];
    [_nameLabel setTextColor:_nameColor];
    [_nameLabel setNumberOfLines:0];
    _nameLabel.lineHeight = 0.85;
    [self.contentView addSubview:_nameLabel];
    
}

- (void)setupConstraints {
    
    self.portraitImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.portraitLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal Constraints
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.portraitImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.portraitImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:0.68 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.portraitLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:30]];
    
    // Vertical Constraints
    self.nameLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.portraitLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.portraitLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.contentView addConstraint:self.nameLabelCenterYConstraint];
    [self.contentView addConstraint:self.portraitLabelCenterYConstraint];
    
}

- (void)setMaxParallaxOffset:(CGFloat)maxParallaxOffset {
    
    _maxParallaxOffset = maxParallaxOffset;
    [self setNeedsUpdateConstraints];
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    [super applyLayoutAttributes:layoutAttributes];
    NSParameterAssert(layoutAttributes != nil);
    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
    ParallaxLayoutAttributes *parallaxLayoutAttributes = (ParallaxLayoutAttributes *)layoutAttributes;
    self.nameLabelCenterYConstraint.constant = 1.5*parallaxLayoutAttributes.parallaxOffset.y;
    self.portraitLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
    
}

@end
