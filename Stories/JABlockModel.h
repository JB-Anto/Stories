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
@property (strong,nonatomic) NSString <Optional> *title;
@property (strong,nonatomic) NSString <Optional> *location;
@property (strong,nonatomic) NSArray <Optional> *resumes;
@property (strong,nonatomic) NSArray <Optional> *links;
@property (strong,nonatomic) NSString <Optional> *image;
@property (strong,nonatomic) NSString <Optional> *author;
@property (strong,nonatomic) NSString <Optional> *number;


@end
