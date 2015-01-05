//
//  AFPagerBar.m
//  AirFrance
//
//  Created by Emal Saifi [DAN-PARIS] on 07/02/14.
//  Copyright (c) 2014 Emal Saifi [DAN-PARIS]. All rights reserved.
//

#import "JAPagerBar.h"


@interface JAPagerBar()

- (void)drawPagerBar;
- (void)drawCirclePagerBar;

@property (nonatomic) CGPoint circleCenter;
@property (nonatomic) CGFloat circleRadius;

@property (strong, nonatomic) UIImageView *circleView;

@end

@implementation JAPagerBar
{
    int _nbSection, _sectionWidth, _sectionHeight;
}

- (id)initWithNbSection:(int)nbSection sectionWidth:(float)sectionWidth sectionHeight:(int)sectionHeight{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, nbSection * sectionWidth, sectionHeight)]){
        // Initialization code
        _nbSection = nbSection;
        _sectionWidth = sectionWidth;
        _sectionHeight = sectionHeight;
        
        [self drawCirclePagerBar];
    }
    return self;

}
// Rectangle Pagination by Coco
- (void)drawPagerBar{
    
    // Label PagerBar
   UILabel *pageBarIndexLabel;
   self.referenceLabelsArray = [NSMutableArray array];
    


   for (int i = 0; i<_nbSection; i++) {
       pageBarIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*_sectionWidth, -30, _sectionWidth, 30)];
       pageBarIndexLabel.textAlignment = NSTextAlignmentCenter;
       pageBarIndexLabel.text = [NSString stringWithFormat:@"%d", (i+1)];
       pageBarIndexLabel.textColor = [UIColor whiteColor];
//       pageBarIndexLabel.font = AFFontIndexPageBarNormal;
        [self addSubview:pageBarIndexLabel];
       [self.referenceLabelsArray addObject:pageBarIndexLabel];
   }
//    [[self.referenceLabelsArray objectAtIndex:0] setFont:AFFontIndexPageBarCurrent];
    
    // View PagerBar Coco
    UIView *pagerBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _nbSection * _sectionWidth, _sectionHeight)];
//    pagerBarView.backgroundColor = AFColorLightBlue;
    [self addSubview:pagerBarView];
    
    self.currentPageView = [[UIView alloc] initWithFrame:CGRectMake(0, -1, _sectionWidth, _sectionHeight*2)];
    self.currentPageView.backgroundColor = [UIColor whiteColor];
    [pagerBarView addSubview:self.currentPageView];
    
}
// Circle Pagination by Anto
-(void)drawCirclePagerBar{
    
    self.circlePaginations = [NSMutableArray array];
    UIView *pagerBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _nbSection * _sectionWidth, _sectionHeight)];
    [self addSubview:pagerBarView];
    
    for (int i = 0; i < _nbSection; i++) {
        
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(i*_sectionWidth, 0, _sectionWidth, _sectionHeight)];
        [pagerBarView addSubview: circleView];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [[self makeCircleAtLocation:CGPointMake(_sectionWidth / 2, _sectionHeight / 2) radius:4.0] CGPath];
        shapeLayer.fillColor = [[UIColor pxColorWithHexValue:@"41373c"]CGColor];
        [circleView.layer addSublayer:shapeLayer];
        
        [self.circlePaginations addObject:shapeLayer];
    }
    [[self.circlePaginations firstObject] setFillColor:[[UIColor whiteColor] CGColor]];
}

// Create circle
- (UIBezierPath *)makeCircleAtLocation:(CGPoint)location radius:(CGFloat)radius
{
    self.circleCenter = location;
    self.circleRadius = radius;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:self.circleCenter
                    radius:self.circleRadius
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    
    return path;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
