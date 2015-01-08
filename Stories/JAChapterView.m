//
//  JAChapterView.m
//  Stories
//
//  Created by LANGLADE Antonin on 06/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import "JAChapterView.h"

@implementation JAChapterView{
        UILabel *titleLBL;
}

- (id)initWithFrame:(CGRect)frame blocks:(JAArticleModel*)blocks percent:(float)percent
{
    self = [super initWithFrame:frame];
    
    
    if(self)
    {
        self.blocks = blocks;

        // Date out format
        self.dateFormater = [[NSDateFormatter alloc]init];
        [self.dateFormater setDateFormat:@"MMM,\u00A0dd"];
        
        // Date in format
        self.dateFormaterFromString = [[NSDateFormatter alloc]init];
        [self.dateFormaterFromString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];

        int rangeFinalUnderline = (int)(percent * [[self.blocks title] length] / 100);
        
        titleLBL = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, frame.size.width - 40, frame.size.height)];
        titleLBL.lineBreakMode = NSLineBreakByWordWrapping;
        titleLBL.numberOfLines = 0;
        titleLBL.textColor = [UIColor whiteColor];
        titleLBL.attributedText = [self createCompleteString:rangeFinalUnderline];
        titleLBL.tag = 1;
        titleLBL.alpha = 0;
        
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:titleLBL];
        titleLBL.transform = CGAffineTransformMakeScale(0.5, 0.5);
        
        [self addSubview:titleLBL];

    }
    
    return self;
}
-(NSMutableAttributedString*)createCompleteString:(int)percent{
    NSString *text = [self.blocks title];
    
    NSString *dateString = [self.blocks createdAt];
    
    NSDate *date = [self.dateFormaterFromString dateFromString:dateString];
    NSString *finalDate = [self.dateFormater stringFromDate:date];

    NSMutableAttributedString *completeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",text,[finalDate lowercaseString]]];

    [completeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"News-Plantin-Pro-Regular" size:32.0] range:NSMakeRange(0,[text length])];
    [completeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Calibre-Thin" size:20.0] range:NSMakeRange([text length]+1,[finalDate length])];
    
    [completeString addAttribute:NSBaselineOffsetAttributeName value:@(10) range:NSMakeRange([text length]+1,[finalDate length])];
    [completeString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0,percent)];
    
    return completeString;
}
-(void)updatePercent:(float)percent{

    int rangeFinalUnderline = (int)(percent * [[self.blocks title] length] / 100);
    titleLBL.attributedText = [self createCompleteString:rangeFinalUnderline];
    [titleLBL setNeedsDisplay];

}
-(void)setNeedsDisplay{
    [super setNeedsDisplay];
}
-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

@end
