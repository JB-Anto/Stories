//
//  JAPlistManager.h
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAPlistManager.h"

@interface JAPlistManager()

@property (strong, nonatomic) NSString *plistPath;

@end

@implementation JAPlistManager

static JAPlistManager *sharedInstance = nil;

+ (id)sharedInstance
{
    if(sharedInstance == nil)
    {
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    if(self = [super init])
    {
        self.manager = [JAManagerData sharedManager];
        // Search if the plist already exist
        NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destinationPath = [destinationPath stringByAppendingPathComponent:@"stories.plist"];
        
        // If the file doesn't exist in the Documents Folder, copy it from the App Bundle to the Documents Folder.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:destinationPath])
        {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"stories" ofType:@"plist"];

            [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:nil];
        }
        
        self.plistPath = destinationPath;
        
        NSMutableDictionary *plistData = [self getPlistData];
        
        if ([[self getObject:@"follow"] count] == 0) {
            
            NSMutableArray *stories = [NSMutableArray array];
            for (int i = 0; i < [self.manager getNumberOfStories]; i++) {
                [stories addObject:@0];
            }
            [plistData setObject:stories forKey:@"follow"];
            [self writeDataToPlist:plistData];
        }
        if([[self getObject:@"percent"]count] == 0){
            
        }
//        for (int v = 0; v < [[[self.manager getCurrentStorie] chapters] count]; v++) {
//            for (int w = 0; w < [[self.titlesArray objectAtIndex:v] count] ; w++) {
//                [self.percentArray addObject:[NSNumber numberWithFloat:0.0]];
//            }
//        }

    }
    return self;
}

#pragma mark - User info value handlers

- (NSMutableArray *)getObject:(NSString*)key
{
    NSLog(@"stories %@", [self getPlistData]);
//    NSLog(@"ARRAY %lu",(unsigned long)[[[[self getPlistData] objectForKey:@"cover"] objectForKey:follow] count]);
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[self getPlistData] objectForKey:key]];
    return array;

}

- (void)setValueForKey:(NSString *)key value:(NSNumber*)value index:(NSInteger)index
{
    
    
    NSMutableDictionary *plistData = [self getPlistData];
    
    NSMutableArray *follow = [self getObject:key];
    
//    NSLog(@"index %li || value %@ || follow %@",(long)index,value,follow);
    [follow removeObjectAtIndex:index];
    [follow insertObject:value atIndex:index];
    [plistData setObject:follow forKey:key];
    
    [self writeDataToPlist:plistData];
    
    NSLog(@" %@ - %@ ",key, [self getObject:key] );

}

#pragma mark - Update data handler

- (void)writeDataToPlist:(id)data
{
    NSError *error;
    NSData *datas = [NSPropertyListSerialization dataWithPropertyList:data format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    
    [datas writeToFile:self.plistPath atomically:YES];
}


#pragma mark - Utils

- (NSMutableDictionary*)getPlistData
{
    return [NSMutableDictionary dictionaryWithContentsOfFile:self.plistPath];
}

@end
