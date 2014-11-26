//
//  JAChapterScrollView.m
//  Stories
//
//  Created by Antonin Langlade on 26/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAChapterScrollView.h"

@implementation JAChapterScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.manager = [JAManagerData sharedManager];
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
        self.showsHorizontalScrollIndicator = NO;
        NSUInteger chaptersCount = [[[self.manager getCurrentStorie] chapters] count];
        for(int i = 0; i < chaptersCount; i++){
            
            UILabel *chapterLBL = [[UILabel alloc]initWithFrame:CGRectMake(i * self.frame.size.width / 2 + 20 , 0, self.frame.size.width - 20, self.frame.size.height)];
            chapterLBL.text = [[[[self.manager getCurrentStorie] chapters]objectAtIndex:i]title] ;
            chapterLBL.font = [UIFont fontWithName:@"Circular-Std-Book" size:18];
            chapterLBL.textColor = [UIColor pxColorWithHexValue:@"#383561"];
            [self addSubview:chapterLBL];
        }
        
        
        [self setContentSize:CGSizeMake((self.frame.size.width / 2) * (chaptersCount + 1), self.frame.size.height)];
    
    }
    
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
