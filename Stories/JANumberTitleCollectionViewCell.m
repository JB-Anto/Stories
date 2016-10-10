//
//  JANumberTitleCollectionViewCell.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 22/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JANumberTitleCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JANumberTitleCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint *numberLabelTopConstraint;

@property (nonatomic, strong) UIFont *numberFont;
@property (nonatomic, strong) UIColor *numberColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;

@end

@implementation JANumberTitleCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self == nil) {
        return nil;
    }
    
    self.manager = [JAManagerData sharedManager];
    
    _numberFont = [UIFont fontWithName:@"News-Plantin-Pro-Regular" size:90];
    _numberColor = [self.manager getCurrentColor];
    _textFont = [UIFont fontWithName:@"Calibre-Regular" size:24.0];
    _textColor = [self.manager getCurrentTextColor];
    
    // Creating subviews
    [self setupNumberLabel];
    [self setupTextLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
    
}

- (void)setupNumberLabel {
    
    _numberLabel = [JAUILabel new];
    [_numberLabel setFont:_numberFont];
    [_numberLabel setTextColor:_numberColor];
    [self.contentView addSubview:_numberLabel];
    
}

- (void)setupTextLabel {

    _textLabel = [JAUILabel new];
    [_textLabel setNumberOfLines:0];
    [_textLabel setFont:_textFont];
    [_textLabel setTextColor:_textColor];
    _textLabel.lineHeight = 1.1;
    _textLabel.letterSpacing = 0.7;
    [self.contentView addSubview:_textLabel];
    
}

- (void)setupConstraints {
    
    self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal Constraints
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    
    // Vertical Constraints
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeBottom  relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    self.numberLabelTopConstraint = [NSLayoutConstraint constraintWithItem:self.numberLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self.contentView addConstraint:self.numberLabelTopConstraint];
    
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
    self.numberLabelTopConstraint.constant = 3*parallaxLayoutAttributes.parallaxOffset.y;
    
}

@end
