//
//  QuotesCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAQuotesCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JAQuotesCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint *authorLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *authorLabelCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *quoteLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *quoteLabelCenterYConstraint;

@property (nonatomic, strong) UIFont *authorFont;
@property (nonatomic, strong) UIColor *authorColor;
@property (nonatomic, strong) UIFont *quoteFont;
@property (nonatomic, strong) UIColor *quoteColor;

@end

@implementation JAQuotesCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
    
    // Main characteristics of labels in the view
    _authorFont = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:28.0];
    _authorColor = [UIColor colorWithHue:0.08 saturation:0.74 brightness:0.93 alpha:1];
    _quoteFont = [UIFont fontWithName:@"Circular-Std-Book" size:26.0];
    _quoteColor  = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:.9];
    
    // Creating subviews
    [self setupAuthorLabel];
    [self setupQuoteLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    // ********TEMPORARY********
//        [self.quoteLabel setBackgroundColor:[UIColor redColor]];
//        [self.authorLabel setBackgroundColor:[UIColor redColor]];
//        [self setBackgroundColor:[UIColor greenColor]];
    
    return self;
    
}

- (void)setupAuthorLabel
{
    
    _authorLabel = [JAUILabel new];
    [_authorLabel setNumberOfLines:0];
    [_authorLabel setFont:_authorFont];
    [_authorLabel setTextAlignment:NSTextAlignmentRight];
    [_authorLabel setTextColor:_authorColor];
    _authorLabel.lineHeight = 1.3;
    
    [self.contentView addSubview:_authorLabel];
    
}

- (void)setupQuoteLabel
{

    _quoteLabel = [JAUILabel new];
    [_quoteLabel setNumberOfLines:0];
    [_quoteLabel setFont:_quoteFont];
    [_quoteLabel setTextColor:_quoteColor];
    _quoteLabel.lineHeight = 1.08;
    
    [self.contentView addSubview:_quoteLabel];
    
}

- (void)setupConstraints
{

    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.quoteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal Constraints
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.quoteLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.quoteLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.authorLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.quoteLabel attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.authorLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.quoteLabel attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

    // Vertical Constraints
    
    self.authorLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.authorLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.quoteLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.contentView addConstraint:self.authorLabelCenterYConstraint];
    
}

- (void)updateConstraints
{
    [super updateConstraints];
    self.quoteLabelHeightConstraint.constant = 2 * self.maxParallaxOffset;
    self.authorLabelHeightConstraint.constant = 2 * self.maxParallaxOffset;
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
    self.authorLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
    
}

@end
