//
//  JAUILabel.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAUILabel.h"

@implementation JAUILabel

-(void)initWithString:(NSString *)text
{
    [self setText:text];
    
    if(self.lineHeight) {
        [self applyLineHeight];
    }
    
    if(self.letterSpacing) {
        [self applyLetterSpacing];
    }
    
    [self sizeToFit];
}

-(void)applyLineHeight
{
    NSMutableAttributedString* attrString = self.attributedText.mutableCopy;
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setLineHeightMultiple:self.lineHeight];
    
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, [self.text length])];
    
    self.attributedText = attrString;
    
}

-(void)applyLetterSpacing
{
    NSMutableAttributedString* attrString = self.attributedText.mutableCopy;
    [attrString addAttribute:NSKernAttributeName
                value:@(self.letterSpacing)
                range:NSMakeRange(0, [self.text length])];
    
    self.attributedText = attrString;
    
}

-(void)setFrameForThisBounds:(CGRect)boundsHoped {
    
    CGSize optimalSizeForLabel = boundsHoped.size;
    
    if(optimalSizeForLabel.width == 0 && optimalSizeForLabel.height == 0) {
        optimalSizeForLabel = self.bounds.size;
    } else {
        optimalSizeForLabel = [self sizeThatFits:boundsHoped.size];
    }
    [self setFrame:CGRectMake(boundsHoped.origin.x, boundsHoped.origin.y, optimalSizeForLabel.width, optimalSizeForLabel.height)];
    
}
@end
