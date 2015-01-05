//
//  ParagraphCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAParagraphCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JAParagraphCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint *paragraphLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *paragraphLabelCenterYConstraint;
@property (nonatomic, strong) UIFont *paragraphFont;
@property (nonatomic, strong) UIColor *paragraphColor;
@property (nonatomic, strong) UIColor *linkColor;

@end

@implementation JAParagraphCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{

    
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
    
    self.manager = [JAManagerData sharedManager];
    
    // Main characteristics of labels in the view
    _paragraphFont = [UIFont fontWithName:@"News-Plantin-Pro-Regular" size:18.0];
    _paragraphColor = [self.manager getCurrentTextColor];
    _linkColor = [self.manager getCurrentColor];
    
    // Creating subviews
    [self setupParagraphLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
}

- (void)setupParagraphLabel
{
    _paragraphLabel = [JAUITextView new];
    [_paragraphLabel setScrollEnabled:NO];
    [_paragraphLabel setEditable:NO];
    [_paragraphLabel setSelectable:NO];
    [_paragraphLabel setFont:_paragraphFont];
    [_paragraphLabel setTextColor:_paragraphColor];
    _paragraphLabel.linkColor = _linkColor;
    _paragraphLabel.lineHeight = 1.4;
    _paragraphLabel.letterSpacing = -0.01;
    
    // Ready to add in parent view
    [self.contentView addSubview:_paragraphLabel];
}

- (void)setupConstraints
{
    self.paragraphLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal constraints
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.paragraphLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.paragraphLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    // Vertical constraints
    self.paragraphLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.paragraphLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.contentView addConstraint:self.paragraphLabelCenterYConstraint];
    
}

//- (void)updateConstraints
//{
//    [super updateConstraints];
//    self.paragraphLabelHeightConstraint.constant = 2 * self.maxParallaxOffset;
//}
//
//- (void)setMaxParallaxOffset:(CGFloat)maxParallaxOffset
//{
//    _maxParallaxOffset = maxParallaxOffset;
//    [self setNeedsUpdateConstraints];
//}

//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
//{
//    [super applyLayoutAttributes:layoutAttributes];
//    
//    NSParameterAssert(layoutAttributes != nil);
//    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
//    
//    ParallaxLayoutAttributes *parallaxLayoutAttributes = (ParallaxLayoutAttributes *)layoutAttributes;
//    self.paragraphLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
//    
//}

@end
