//
//  JAChapterModel.h
//  Stories
//
//  Created by LANGLADE Antonin on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JAArticleModel.h"

@protocol JAChapterModel <NSObject>
@end

@interface JAChapterModel : JSONModel

@property (assign, nonatomic) uint id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray<JAArticleModel> *articles;


@end
