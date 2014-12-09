//
//  CreditsCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACreditsView.h"

@implementation JACreditsView
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
        
        // Main characteristics of labels in the view
        UIFont *font   = [UIFont fontWithName:@"Circular-Std-Book" size:11.0];
        UIColor *color = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:1];
        
        self.titleLabel = [JAUILabel new];
        [self.titleLabel setFont:font];
        [self.titleLabel setTextColor:color];
        self.titleLabel.lineHeight = 1.3;
        
        self.namesLabel = [JAUILabel new];
        [self.namesLabel setFont:font];
        [self.namesLabel setNumberOfLines:0];
        [self.namesLabel setTextColor:color];
        self.namesLabel.lineHeight = 1.3;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.namesLabel];
        
        /********TEMPORARY********/
//        [self.titleLabel setBackgroundColor:[UIColor redColor]];
//        [self.namesLabel setBackgroundColor:[UIColor blueColor]];
//        [self setBackgroundColor:[UIColor greenColor]];
        
    }
    
    return self;
    
}

@end
