//
//  KeyNumberCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAKeyNumberCollectionViewCell.h"

@implementation JAKeyNumberCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
        
        // Main characteristics of labels in the view
        UIFont *numberFont   = [UIFont fontWithName:@"News-Plantin-Pro-Regular" size:82.5];
        UIColor *numberColor = [UIColor colorWithHue:0.08 saturation:0.74 brightness:0.93 alpha:1];
        UIFont *descriptionFont    = [UIFont fontWithName:@"Circular-Std-Book" size:24.0];
        UIColor *descriptionColor  = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:.9];
        
        // Initial Setting - Number Label
        self.numberLabel = [JAUILabel new];
        [self.numberLabel setNumberOfLines:0];
        [self.numberLabel setFont:numberFont];
        [self.numberLabel setTextColor:numberColor];
        
        // Initial Setting - Description Label
        self.descriptionLabel = [JAUILabel new];
        [self.descriptionLabel setNumberOfLines:0];
        [self.descriptionLabel setFont:descriptionFont];
        [self.descriptionLabel setTextColor:descriptionColor];
        
        // Ready to add in parent view
        [self addSubview:self.numberLabel];
        [self addSubview:self.descriptionLabel];
        
        // ********TEMPORARY********
//        [self.descriptionLabel setBackgroundColor:[UIColor redColor]];
//        [self.numberLabel setBackgroundColor:[UIColor blueColor]];
//        [self setBackgroundColor:[UIColor greenColor]];
        
    }
    
    return self;
    
}
@end
