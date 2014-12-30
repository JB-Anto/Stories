//
//  ImageCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAImageCollectionViewCell.h"
#import "ParallaxLayoutAttributes.h"

@interface JAImageCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint *imageViewHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageViewLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageViewCenterYConstraint;
@property (nonatomic, strong) NSLayoutConstraint *legendLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *legendLabelLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *legendLabelCenterYConstraint;
@property (nonatomic, strong) UIFont *legendFont;
@property (nonatomic, strong) UIColor *legendColor;

@end

@implementation JAImageCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
        
    // Main characteristics of labels in the view
    _legendFont = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:13.0];
    _legendColor = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:1];
    
    // Initial Setting - Resume Label
    [self setupImageView];
    [self setupLegendLabel];
    [self setupGestureRecognizer];
    [self setupConstraints];
    
    [self setNeedsUpdateConstraints];
    
    return self;
    
}


- (void)setupImageView
{
    
    _imageView = [UIImageView new];
    [_imageView setAlpha:.4];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.contentView addSubview:_imageView];
    
}

- (void)setupLegendLabel
{
    
    _legendLabel = [JAUILabel new];
    [_legendLabel setNumberOfLines:0];
    [_legendLabel setFont:_legendFont];
    [_legendLabel setTextColor:_legendColor];
    _legendLabel.lineHeight = 1.6;
    [self.contentView addSubview:_legendLabel];
    
}

- (void)setupGestureRecognizer
{
    self.imageView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *recognizer = [UISwipeGestureRecognizer new];
    recognizer.delegate = self;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self addGestureRecognizer:recognizer];
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self addGestureRecognizer:recognizer];
    
}

- (void)setupConstraints
{
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.legendLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Horizontal Constraints
    self.imageViewLeftConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:-10];
    [self.contentView addConstraint:self.imageViewLeftConstraint];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0]];
    self.legendLabelLeftConstraint = [NSLayoutConstraint constraintWithItem:self.legendLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeRight multiplier:0.5 constant:0];
    [self.contentView addConstraint:self.legendLabelLeftConstraint];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.legendLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0]];
    
    // Vertical Constraints
    self.imageViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    self.legendLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.legendLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self.contentView addConstraint:self.imageViewCenterYConstraint];
    [self.contentView addConstraint:self.legendLabelCenterYConstraint];
    
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    NSParameterAssert(layoutAttributes != nil);
    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
    ParallaxLayoutAttributes *parallaxLayoutAttributes = (ParallaxLayoutAttributes *)layoutAttributes;
    self.legendLabelCenterYConstraint.constant = parallaxLayoutAttributes.parallaxOffset.y;
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)gesture
{
    
    NSLog(@"Swipe");
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [self layoutIfNeeded];
        self.imageViewLeftConstraint.constant = CGRectGetWidth(self.contentView.bounds)/2 - CGRectGetWidth(self.imageView.bounds)/2;
        self.legendLabelLeftConstraint.constant = -CGRectGetWidth(self.imageView.bounds);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self layoutIfNeeded];
            self.imageView.alpha = 1.0;
            self.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
            self.legendLabel.alpha = 0.1;
            
        }];
    }
    
    
    if ((gesture.direction == UISwipeGestureRecognizerDirectionLeft)) {
        
        [self layoutIfNeeded];
        self.imageViewLeftConstraint.constant = -10;
        self.legendLabelLeftConstraint.constant = 0;
        
        [UIView animateWithDuration:0.4 animations:^{
            
            [self layoutIfNeeded];
            self.imageView.alpha = 0.4;
            self.imageView.transform = CGAffineTransformMakeScale(1, 1);
            
            self.legendLabel.alpha = 1;
        }];
    }
    
}


@end
