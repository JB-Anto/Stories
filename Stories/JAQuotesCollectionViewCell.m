//
//  QuotesCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAQuotesCollectionViewCell.h"

@implementation JAQuotesCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
        NSLog(@"Init imageCell");
        
        // For better perfomance
        [self setOpaque:NO];
        
        // Main characteristics of labels in the view
        UIFont *authorFont   = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:28.0];
        UIColor *authorColor = [UIColor colorWithHue:0.08 saturation:0.74 brightness:0.93 alpha:1];
        UIFont *quoteFont    = [UIFont fontWithName:@"Circular-Std-Book" size:26.0];
        UIColor *quoteColor  = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:.9];
        
        // Initial Setting - Resume Label
        self.authorLabel = [JAUILabel new];
        [self.authorLabel setNumberOfLines:0];
        [self.authorLabel setFont:authorFont];
        [self.authorLabel setTextAlignment:NSTextAlignmentRight];
        [self.authorLabel setTextColor:authorColor];
        
        self.quoteLabel = [JAUILabel new];
        [self.quoteLabel setNumberOfLines:0];
        [self.quoteLabel setFont:quoteFont];
        [self.quoteLabel setTextColor:quoteColor];
        
        // Ready to add in parent view
        [self addSubview:self.authorLabel];
        [self addSubview:self.quoteLabel];
        
        // ********TEMPORARY********
//        [self.quoteLabel setBackgroundColor:[UIColor redColor]];
//        [self.authorLabel setBackgroundColor:[UIColor redColor]];
//        [self setBackgroundColor:[UIColor greenColor]];
        
    }
    
    return self;
    
}
@end
