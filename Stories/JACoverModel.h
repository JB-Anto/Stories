//
//  JACoverModel.h
//  Stories
//
//  Created by LANGLADE Antonin on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol JACoverModel <NSObject>

@end

@interface JACoverModel : JSONModel

@property (assign, nonatomic) uint id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *background;
@property (strong, nonatomic) NSString *foreground;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSArray *paths;

@end
