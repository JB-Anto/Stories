//
//  JALoaderView.m
//  Stories
//
//  Created by Antonin Langlade on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JALoaderView.h"

@implementation JALoaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
        UIView *loader = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 120, 120)];
        
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 0; i < 40; i++) {
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loader_%i.png",i]]];
        }
//        NSArray *images = [NSArray arrayWithObjects:img1,img2, nil];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 160.0, 160.0)];
        [self.imageView setAnimationImages:images];
        [self.imageView setAnimationRepeatCount:1];
        [self.imageView setAnimationDuration:2];

        [loader addSubview:self.imageView];
        [self addSubview:loader];
        
    }
    
    return self;
    
}


@end
