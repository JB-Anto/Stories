//
//  JSONFetcher.m
//  AirFrance
//
//  Created by Corentin Bac [DAN-PARIS] on 12/02/14.
//  Copyright (c) 2014 Emal Saifi [DAN-PARIS]. All rights reserved.
//

#import "JSONFetcher.h"

@implementation JSONFetcher

+ (NSDictionary *)staticDatasWithPathResource:(NSString *)path
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];

    NSError *error = nil;

    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
}

+ (NSArray *)getArrayFromJson:(NSString *)path {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    NSError *e = nil;
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
}

@end
