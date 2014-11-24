//
//  EMManagerData.h
//  com.gobelins.Estimap
//
//  Created by Antonin Langlade on 26/02/2014.
//  Copyright (c) 2014 Antonin Langlade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAStoriesModel.h"

@interface JAManagerData : NSObject

@property (strong,nonatomic) JAStoriesModel *data;


+ (id)sharedManager;

//-(UIViewController*)changeGame;

@end
