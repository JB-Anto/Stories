//
//  JAChapterScrollView.h
//  Stories
//
//  Created by Antonin Langlade on 26/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JALabelChapter.h"

@interface JAChapterScrollView : UIScrollView <UIScrollViewDelegate>

@property (strong, nonatomic) JAManagerData *manager;
@property (strong, nonatomic) NSMutableArray *chapterArray;

@end
