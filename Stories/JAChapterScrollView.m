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
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
        self.showsHorizontalScrollIndicator = NO;
        NSUInteger chaptersCount = [[[self.manager getCurrentStorie] chapters] count];
        for(int i = 0; i < chaptersCount; i++){
            
            UILabel *chapterLBL = [[UILabel alloc]initWithFrame:CGRectMake(i * self.frame.size.width + 20 , 0, self.frame.size.width - 40, self.frame.size.height)];
            chapterLBL.text = [[[[self.manager getCurrentStorie] chapters]objectAtIndex:i]title] ;
            chapterLBL.font = [UIFont fontWithName:@"Circular-Std-Book" size:18];
            chapterLBL.textColor = [UIColor pxColorWithHexValue:@"#383561"];
//            chapterLBL.layer.borderColor = [UIColor greenColor].CGColor;
//            chapterLBL.layer.borderWidth = 3.0;

            [self addSubview:chapterLBL];
        }
        
        [self setContentSize:CGSizeMake(self.frame.size.width  * chaptersCount , self.frame.size.height)];
        
    }
    
    return self;
}


@end
