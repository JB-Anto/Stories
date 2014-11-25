//
//  ImageCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAImageCollectionViewCell.h"

@implementation JAImageCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
        [self setBackgroundColor:[UIColor greenColor]];
        NSLog(@"Init imageCell");
    }
    
    return self;
    
}
@end
