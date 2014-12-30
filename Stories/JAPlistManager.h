//
//  JAPlistManager.h
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JAManagerData.h"
@interface JAPlistManager : NSObject

@property (strong,nonatomic) JAManagerData *manager;

+ (id)sharedInstance;

- (NSMutableArray *)getObject:(NSString*)key;

- (void)setValueForKey:(NSString *)key value:(NSNumber*)value index:(NSInteger)index;

@end
