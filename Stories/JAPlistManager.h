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

//- (NSString*)getObject:(NSString*)key;
- (NSMutableArray *)getObject:(NSString*)key;
- (NSNumber *)getPercentRead;
- (NSNumber *)getPercentRead:(NSInteger)chapter article:(NSInteger)article;
- (NSString*)getTuto;

//- (void)setValueForKey:(NSString *)key value:(NSString *)value;
- (void)setTuto:(NSString *)value;
- (void)setValueForKey:(NSString *)key value:(NSNumber*)value index:(NSInteger)index;
- (void)setPercentRead:(NSNumber*)value storie:(NSInteger)storie chapter:(NSInteger)chapter article:(NSInteger)article;

@end
