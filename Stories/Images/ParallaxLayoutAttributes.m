//
//  ParallaxLayoutAttributes.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 10/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "ParallaxLayoutAttributes.h"

@implementation ParallaxLayoutAttributes

- (id)copyWithZone:(NSZone *)zone
{
    ParallaxLayoutAttributes *copy = [super copyWithZone:zone];
    NSAssert([copy isKindOfClass:[self class]], @"Copy must have the same class");
    copy.parallaxOffset = self.parallaxOffset;
    return copy;
}

- (BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:[ParallaxLayoutAttributes class]]) {
        return NO;
    }
    
    ParallaxLayoutAttributes *otherObject = object;
    
    if(!CGPointEqualToPoint(self.parallaxOffset, otherObject.parallaxOffset)) {
        return NO;
    }
    
    return  [super isEqual:otherObject];
    
}

@end
