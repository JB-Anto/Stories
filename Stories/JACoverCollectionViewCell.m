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
        
        self.manager = [JAManagerData sharedManager];
        self.plistManager = [JAPlistManager sharedInstance];
        
        [self.plistManager getCoverFollow:@"follow"];
//        [self.plistManager setValue:@"1" forKey:@"follow"];
        
        self.backgroundIV = [[UIImageView alloc] initWithFrame:self.bounds];
        self.foregroundIV = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/3, 0, self.bounds.size.width, self.bounds.size.height)];
        
        self.organicView = [[JAOrganicView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) paths:[[[self.manager getCurrentStorie]cover]paths]];

        self.locationLBL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        self.locationLBL.textAlignment = NSTextAlignmentCenter;
        self.locationLBL.textColor = [UIColor whiteColor];
        self.locationLBL.font = [UIFont fontWithName:@"Young-Serif-Regular" size:50.0];
        
        self.titleLBL = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, self.bounds.size.width, 70)];
        self.titleLBL.textAlignment = NSTextAlignmentCenter;
        self.titleLBL.textColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
        self.titleLBL.font = [UIFont fontWithName:@"Circular-Std-Book" size:24.0];
        self.titleLBL.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLBL.numberOfLines = 2;

        self.titleView = [[UIView alloc]initWithFrame:CGRectMake(50, self.bounds.size.height/2 - 150/2, self.bounds.size.width, 200)];
        self.titleView.alpha = 0;
        
        
        [self addSubview:self.backgroundIV];
        [self addSubview:self.foregroundIV];
        [self addSubview:self.organicView];
        [self.titleView addSubview:self.locationLBL];
        [self.titleView addSubview:self.titleLBL];
        [self addSubview:self.titleView];


    }
        
    return self;
    
}
-(void)animateEnter{
    [self.titleView setEasingFunction:easeOutExpo forKeyPath:@"transform"];
    [UIView animateWithDuration:1 animations:^{
        self.titleView.transform = CGAffineTransformMakeTranslation(-50, 0);
    } completion:^(BOOL finished){
        [self.titleView removeEasingFunctionForKeyPath:@"transform"];
    }];
    
    [self.foregroundIV setEasingFunction:easeOutExpo forKeyPath:@"transform"];
    [UIView animateWithDuration:1 animations:^{
        self.foregroundIV.transform = CGAffineTransformMakeTranslation(-self.bounds.size.width/3, 0);
    } completion:^(BOOL finished){
        [self.foregroundIV removeEasingFunctionForKeyPath:@"transform"];
    }];
    [UIView animateWithDuration:.8 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.titleView.alpha = 1;
    } completion:nil];
}
-(void)resetAnimation{
    
    self.titleView.transform = CGAffineTransformMakeTranslation(50, 0);
    self.titleView.alpha = 0;
    self.foregroundIV.transform = CGAffineTransformMakeTranslation(self.bounds.size.width/3, 0);
    [self.organicView resetAnimation];
}
@end
