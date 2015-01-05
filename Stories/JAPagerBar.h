//
//  AFPagerBar.h
//  AirFrance
//
//  Created by Emal Saifi [DAN-PARIS] on 07/02/14.
//  Copyright (c) 2014 Emal Saifi [DAN-PARIS]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAPagerBar : UIView

@property(strong, nonatomic) UIView *currentPageView;

@property (strong, nonatomic) NSMutableArray *circlePaginations;
@property (strong, nonatomic) NSMutableArray *referenceLabelsArray;

- (id)initWithNbSection:(int)nbSection sectionWidth:(float)sectionWidth sectionHeight:(int)sectionHeight;

@end
