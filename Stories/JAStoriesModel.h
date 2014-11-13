//
//  JAStoriesModel.h
//  Stories
//
//  Created by LANGLADE Antonin on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JAStorieModel.h"

@interface JAStoriesModel : JSONModel

@property (strong,nonatomic) NSArray<JAStorieModel>* stories;

@end
