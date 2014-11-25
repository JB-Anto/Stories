//
//  TitleCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JATitleCollectionViewCell.h"

@implementation JATitleCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
        NSLog(@"Init TitleCell");
        
        // For better perfomance
        [self setOpaque:NO];
        
        // Main characteristics of labels in the view
        UIFont *titleFont = [UIFont fontWithName:@"Young-Serif-Regular" size:45.0];
        UIFont *infoFont = [UIFont fontWithName:@"Circular-Std-Medium" size:48.0];
        UIColor *titleColor = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:.9];
        UIColor *infoColor = [UIColor colorWithHue:0.08 saturation:0.74 brightness:0.93 alpha:1];
        
        // Initial Setting - Title Label
        self.titleLabel = [JAUILabel new];
        [self.titleLabel setNumberOfLines:0];
        [self.titleLabel setFont:titleFont];
        [self.titleLabel setTextColor:titleColor];
        
        // Initial Setting - Location Label
        self.locationLabel = [JAUILabel new];
        [self.locationLabel setFont:infoFont];
        [self.locationLabel setTextColor:infoColor];
        [self.locationLabel setTextAlignment:NSTextAlignmentCenter];
        
        // Initial Setting - Date Label
        self.dateLabel = [JAUILabel new];
        [self.dateLabel setFont:infoFont];
        [self.dateLabel setTextColor:infoColor];
        [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
        
        // Ready to add in parent view
        [self addSubview:self.locationLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.titleLabel];
        
        // ********TEMPORARY********
        [self setBackgroundColor:[UIColor blueColor]];
    }
    
    return self;
}

@end
