//
//  JAContainerChapterScrollView.h
//  Stories
//
//  Created by LANGLADE Antonin on 06/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAChapterScrollView.h"

@interface JAContainerChapterScrollView : UIView

@property (strong, nonatomic) UIScrollView *chapterScrollView;

- (id)initWithFrame:(CGRect)frame delegate:(id)scrollViewDelegate;

@end
