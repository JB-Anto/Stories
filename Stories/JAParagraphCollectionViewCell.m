//
//  ParagraphCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAParagraphCollectionViewCell.h"

@implementation JAParagraphCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
//        NSLog(@"Init ResumeCell");
        
        // For better perfomance
        [self setOpaque:NO];
        
        // Main characteristics of labels in the view
        UIFont *paragraphFont = [UIFont fontWithName:@"News-Plantin-Pro-Regular" size:18.0];
        UIColor *paragraphColor = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:1];
        
        // Initial Setting - Resume Label
        self.paragraphLabel = [JAUILabel new];
        [self.paragraphLabel setNumberOfLines:0];
        [self.paragraphLabel setFont:paragraphFont];
        [self.paragraphLabel setTextColor:paragraphColor];
        
        // Ready to add in parent view
        [self addSubview:self.paragraphLabel];
        
        // ********TEMPORARY********
//        [self.paragraphLabel setBackgroundColor:[UIColor redColor]];
//        [self setBackgroundColor:[UIColor greenColor]];
        
    }
    
    return self;
}

@end
