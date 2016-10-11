//
//  CreditsCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACreditCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JACreditCollectionViewCell()

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;

@end

@implementation JACreditCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
    
    self.manager = [JAManagerData sharedManager];
    
    // Main characteristics of labels in the view
    _font   = [UIFont fontWithName:@"Helvetica" size:11.0];
    _color = [self.manager getCurrentTextColor];
    
    [self setupTitleLabel];
    [self setupNamesLabel];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
    
}

- (void)setupTitleLabel
{
    _titleLabel = [JAUILabel new];
    [_titleLabel setFont:_font];
    [_titleLabel setTextColor:_color];
    _titleLabel.lineHeight = 1.3;
    
    [self.contentView addSubview:_titleLabel];
    
}

- (void)setupNamesLabel
{

    _namesLabel = [JAUILabel new];
    [_namesLabel setFont:_font];
    [_namesLabel setNumberOfLines:0];
    [_namesLabel setTextColor:_color];
    _namesLabel.lineHeight = 1.3;
    
    [self.contentView addSubview:_namesLabel];
    
}

- (void)setupConstraints
{
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.namesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal position
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.namesLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    // Vertical position
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.namesLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

@end
