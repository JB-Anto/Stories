//
//  JAUILabel.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAUILabel.h"

@implementation JAUILabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setLineHeightWithNumber:(CGFloat) lineHeight
{
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setLineHeightMultiple:lineHeight];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:NSMakeRange(0, [self.text length])];
    
    self.attributedText = attrString;
    
}

-(void)setLineSpacingWithNumber:(CGFloat) lineSpacing
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attrString addAttribute:NSKernAttributeName
                value:@(lineSpacing)
                range:NSMakeRange(0, [self.text length])];
    
    self.attributedText = attrString;
    
}

-(CGRect)calculateRectInBoundingRectWithSize:(CGSize) maximumSize
{
    CGRect labelRect = [self.text boundingRectWithSize:maximumSize
                                  options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine
                                  attributes:@{NSFontAttributeName:self.font}
                                  context:nil];
    
    return labelRect;
    
}

@end
