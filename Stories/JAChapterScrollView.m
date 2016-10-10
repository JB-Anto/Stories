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
        self.chapterArray = [NSMutableArray array];
        self.pagingEnabled = YES;
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor pxColorWithHexValue:[[[self.manager getCurrentStorie] cover] color]];
        self.showsHorizontalScrollIndicator = NO;
        NSUInteger chaptersCount = [[[self.manager getCurrentStorie] chapters] count];
        for(int i = 0; i < chaptersCount; i++){
            
            JALabelChapter *chapterLBL = [[JALabelChapter alloc]initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            chapterLBL.text = [[[[self.manager getCurrentStorie] chapters]objectAtIndex:i]title] ;
            chapterLBL.font = [UIFont fontWithName:@"Calibre-Regular" size:18];
            chapterLBL.textColor = [self.manager getCurrentTextColor];
            
//            chapterLBL.layer.borderColor = [UIColor greenColor].CGColor;
//            chapterLBL.layer.borderWidth = 3.0;
            [self.chapterArray addObject:chapterLBL];
            [self addSubview:chapterLBL];
        }
        
        [self setContentSize:CGSizeMake(self.frame.size.width  * chaptersCount , self.frame.size.height)];
        
    }
    
    return self;
}


@end
