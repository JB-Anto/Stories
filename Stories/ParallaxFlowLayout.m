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
    CGFloat baseline = -2;
    NSMutableArray *sameLineElements = [NSMutableArray array];
    for(ParallaxLayoutAttributes *layoutAttributes in layoutAttributedArray) {
        if(layoutAttributes.representedElementCategory == UICollectionElementCategoryCell || layoutAttributes.representedElementCategory == UICollectionElementCategorySupplementaryView) {
            CGRect frame = layoutAttributes.frame;
            CGFloat centerY = CGRectGetMidY(frame);
            if (ABS(centerY - baseline) > 1) {
                baseline = centerY;
                [self alignToTopForSameLineElements:sameLineElements];
                [sameLineElements removeAllObjects];
            }
            [sameLineElements addObject:layoutAttributes];
            layoutAttributes.parallaxOffset = [self parallaxOffsetForLayoutAttributes:layoutAttributes];
        }
    }
    [self alignToTopForSameLineElements:sameLineElements];
    return layoutAttributedArray;
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ParallaxLayoutAttributes *layoutAttributes = (ParallaxLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    layoutAttributes.parallaxOffset = [self parallaxOffsetForLayoutAttributes:layoutAttributes];
//    layoutAttributes.frame = CGRectOffset(layoutAttributes.frame, 0, -0.5 * CGRectGetHeight(layoutAttributes.frame));
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

- (void)alignToTopForSameLineElements:(NSArray *)sameLineElements
{
    if (sameLineElements.count == 0) {
        return;
    }
    NSArray *sorted = [sameLineElements sortedArrayUsingComparator:^NSComparisonResult(UICollectionViewLayoutAttributes *obj1, UICollectionViewLayoutAttributes *obj2) {
        CGFloat height1 = obj1.frame.size.height;
        CGFloat height2 = obj2.frame.size.height;
        CGFloat delta = height1 - height2;
        return delta == 0. ? NSOrderedSame : ABS(delta)/delta;
    }];
    UICollectionViewLayoutAttributes *tallest = [sorted lastObject];
    [sameLineElements enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectOffset(obj.frame, 0, tallest.frame.origin.y - obj.frame.origin.y);
    }];
}

@end
