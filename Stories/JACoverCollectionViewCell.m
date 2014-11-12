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
        self.backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.backgroundView];
        

    }
        
    return self;
    
}

@end
