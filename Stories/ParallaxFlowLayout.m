//
//  ParallaxFlowLayout.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 10/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "ParallaxFlowLayout.h"
#import "ParallaxLayoutAttributes.h"

static const CGFloat maxParallaxOffset = 30.0;

@implementation ParallaxFlowLayout

+ (Class)layoutAttributesClass
{
    return [ParallaxLayoutAttributes class];
}

- (CGFloat)maxParallaxOffset
{
    return maxParallaxOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *layoutAttributedArray = [super layoutAttributesForElementsInRect:rect];
    
    for(ParallaxLayoutAttributes *layoutAttributes in layoutAttributedArray) {
        if(layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            layoutAttributes.parallaxOffset = [self parallaxOffsetForLayoutAttributes:layoutAttributes];
        }
    }
    
    return layoutAttributedArray;
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ParallaxLayoutAttributes *layoutAttributes = (ParallaxLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    layoutAttributes.parallaxOffset = [self parallaxOffsetForLayoutAttributes:layoutAttributes];
    
    return layoutAttributes;
    
}

- (CGPoint)parallaxOffsetForLayoutAttributes:(ParallaxLayoutAttributes *)layoutAttributes
{
    NSParameterAssert(layoutAttributes != nil);
    NSParameterAssert([layoutAttributes isKindOfClass:[ParallaxLayoutAttributes class]]);
    
    CGRect bounds = self.collectionView.bounds;
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGPoint cellCenter = layoutAttributes.center;
    CGPoint offsetFromCenter = CGPointMake(boundsCenter.x - cellCenter.x, boundsCenter.y - cellCenter.y);
    CGSize cellSize = layoutAttributes.size;
    CGFloat maxVerticalOffsetWhereCellIsStillVisible = (bounds.size.height/2) + (cellSize.height/2);
    CGFloat scaleFactor = self.maxParallaxOffset / maxVerticalOffsetWhereCellIsStillVisible;
    CGPoint parallaxOffset = CGPointMake(0.0, offsetFromCenter.y * scaleFactor);
    
    return parallaxOffset;
}

@end
