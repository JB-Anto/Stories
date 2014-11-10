//
//  JSONFetcher.h
//  AirFrance
//
//  Created by Corentin Bac [DAN-PARIS] on 12/02/14.
//  Copyright (c) 2014 Emal Saifi [DAN-PARIS]. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONFetcher : NSObject

+ (NSDictionary *)staticDatasWithPathResource:(NSString *)path;

+ (NSArray *)getArrayFromJson:(NSString *)path;

@end
