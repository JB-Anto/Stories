//
//  JACreditModel.h
//  Stories
//
//  Created by LANGLADE Antonin on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol JACreditModel <NSObject>

@end

@interface JACreditModel : JSONModel

@property (assign,nonatomic) uint id;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSArray *names;

@end
