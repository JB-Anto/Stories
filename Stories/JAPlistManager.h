//
//  JAPlistManager.h
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JAPlistManager : NSObject

+ (id)sharedInstance;

- (NSString *)getCoverFollow:(NSString*)follow;

- (void)setCoverFollowing:(NSString *)key value:(NSString *)value;

@end
