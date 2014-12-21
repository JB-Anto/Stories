//
//  EMManagerData.h
//
//  Created by Antonin Langlade on 26/02/2014.
//  Copyright (c) 2014 Antonin Langlade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAStoriesModel.h"

@interface JAManagerData : NSObject

@property (strong,nonatomic) JAStoriesModel *data;
@property int currentStorie;
@property int currentChapter;
@property int currentArticle;

+ (id)sharedManager;

-(JAStorieModel*)getCurrentStorie;
-(JAChapterModel*)getCurrentChapter;
-(JAArticleModel*)getCurrentArticle;

@end
