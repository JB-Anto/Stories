//
//  ResumeCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAResumeCollectionViewCell.h"

@implementation JAResumeCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
        NSLog(@"Init ResumeCell");
        
        // For better perfomance
        [self setOpaque:NO];
        
        // Main characteristics of labels in the view
        UIFont *resumeFont = [UIFont fontWithName:@"Circular-Std-Book" size:12.0];
        UIColor *resumeColor = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:1];
        
        // Initial Setting - Resume Label
        self.resumeLabel = [JAUILabel new];
        [self.resumeLabel setNumberOfLines:2];
        [self.resumeLabel setFont:resumeFont];
        [self.resumeLabel setTextColor:resumeColor];
        [self.resumeLabel setBackgroundColor:[UIColor redColor]];
        
        // Ready to add in parent view
        [self addSubview:self.resumeLabel];
        [self setBackgroundColor:[UIColor greenColor]];
    }
    
    return self;
}

@end
