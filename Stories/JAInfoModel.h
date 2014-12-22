//
//  JAInfoModel.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 22/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "JABlockModel.h"

@protocol JAInfoModel <NSObject>

@end

@interface JAInfoModel : JSONModel

@property (assign, nonatomic) uint id;
@property (strong, nonatomic) NSArray <JABlockModel> *blocks;

@end
