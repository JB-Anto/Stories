//
//  JAHeaderCollectionReusableView.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 20/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAHeaderCollectionReusableView.h"

@implementation JAHeaderCollectionReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self == nil) {
        return nil;
    }
    
    //[self setupBackgroundImageView];
    [self setupTitleLabel];
    
    return self;
    
}

- (void)setupTitleLabel
{
    [self addSubview:_titleLabel];
}

- (void)setupBackgroundImageView
{
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:_backgroundImage];
    [self addSubview:backgroundImageView];
    
}

@end
