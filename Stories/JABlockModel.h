//
//  JABlockModel.h
//  Stories
//
//  Created by LANGLADE Antonin on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol JABlockModel <NSObject>

@end

@interface JABlockModel : JSONModel

@property (assign,nonatomic) uint id;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *location;
@property (strong,nonatomic) NSArray *resumes;
@property (strong,nonatomic) NSArray *links;
@property (strong,nonatomic) NSString *image;
@property (strong,nonatomic) NSString *author;
@property (strong,nonatomic) NSString *number;


@end
