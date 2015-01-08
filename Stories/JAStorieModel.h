//
//  JAStories.h
//  Stories
//
//  Created by LANGLADE Antonin on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JACoverModel.h"
#import "JAChapterModel.h"

@protocol JAStorieModel <NSObject>

@end

@interface JAStorieModel : JSONModel

@property (assign, nonatomic) uint id;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) JACoverModel* cover;
@property (strong, nonatomic) NSArray<JAChapterModel>* chapters;

@end
