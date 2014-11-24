//
//  TitleCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JATitleCollectionViewCell.h"

@implementation JATitleCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:CGRectMake(0, 0, self.superview.frame.size.width, 1000)]) {
        NSLog(@"Init TitleCell");
        [self.titleLabel setTextColor:[UIColor orangeColor]];
        [self.titleLabel setFrame:CGRectMake(30, 50, self.bounds.size.width, self.bounds.size.width)];
    }
    
    return self;
}

@end
