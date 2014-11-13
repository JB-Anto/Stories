//
//  JACoverCollectionViewCell.m
//  Stories
//
//  Created by LANGLADE Antonin on 12/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACoverCollectionViewCell.h"

@implementation JACoverCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.backgroundIV = [[UIImageView alloc] initWithFrame:self.bounds];

        self.placesLBL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        self.placesLBL.textAlignment = NSTextAlignmentCenter;
        self.placesLBL.textColor = [UIColor whiteColor];
        self.placesLBL.text = @"REST";
//        self.placesLBL.backgroundColor = [UIColor yellowColor];
        
        [self addSubview:self.backgroundIV];
        [self addSubview:self.placesLBL];
    }
        
    return self;
    
}
-(void)animateEnter{
    [UIView animateWithDuration:1 animations:^{
        self.placesLBL.frame = CGRectMake(100, 400, 100, 40);
    }];
}
-(void)resetAnimation{
    self.placesLBL.frame = CGRectMake(0, 0, 100, 40);
}
@end
