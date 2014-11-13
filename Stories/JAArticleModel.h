//
//  JAArticleModel.h
//  Stories
//
//  Created by LANGLADE Antonin on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JABlockModel.h"
#import "JACreditModel.h"

@protocol JAArticleModel <NSObject>

@end

@interface JAArticleModel : JSONModel

@property (assign, nonatomic) uint id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSString *imageLoading;
@property (strong, nonatomic) NSArray <JABlockModel> *blocks;
@property (strong, nonatomic) NSArray <JACreditModel> *credits;

@end
