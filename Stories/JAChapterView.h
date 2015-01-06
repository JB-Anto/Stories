//
//  JAChapterView.h
//  Stories
//
//  Created by LANGLADE Antonin on 06/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAChapterView : UIView

@property (strong, nonatomic) JAArticleModel *blocks;
@property (strong, nonatomic) NSDateFormatter *dateFormater;
@property (strong, nonatomic) NSDateFormatter *dateFormaterFromString;


- (id)initWithFrame:(CGRect)frame blocks:(JAArticleModel*)blocks percent:(float)percent;
-(void)updatePercent:(float)percent;

@end
