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
        if([[self getPercentReadArray]count] == 0){
            NSMutableArray *percent = [NSMutableArray array];
            for (int i = 0; i < [self.manager getNumberOfStories]; i++) {
                NSMutableArray *storie = [NSMutableArray array];
                for (int j = 0; j < [self.manager getNumberOfChapter:i]; j++) {
                    NSMutableArray *chapter = [NSMutableArray array];
                    for (int k = 0; k < [self.manager getNumberOfArticle:i chapter:j]; k++) {
                        [chapter addObject:@0];
                    }
                    [storie addObject:chapter];
                }
                [percent addObject:storie];
            }
            [plistData setObject:percent forKey:@"percentRead"];
            [self writeDataToPlist:plistData];
            NSLog(@"PERCENT %@", percent);
        }

    }
    return self;
}

#pragma mark - User info value handlers
- (NSString*)getTuto
{
    NSLog(@"test get %@",[[self getPlistData] objectForKey:@"tuto"]);
    return [[self getPlistData] objectForKey:@"tuto"];
}

- (void)setTuto:(NSString *)value{
    NSMutableDictionary *plistData = [self getPlistData];

    [plistData setObject:value forKey:@"tuto"];

    [self writeDataToPlist:plistData];

    NSLog(@" %@ - %@ ",@"tuto", [self getTuto]);
}
- (NSMutableArray *)getObject:(NSString*)key
{
//    NSLog(@"stories %@", [self getPlistData]);
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[self getPlistData] objectForKey:key]];
    return array;

}

//- (void)setValueForKey:(NSString *)key value:(NSString *)value{
//    NSMutableDictionary *plistData = [self getPlistData];
//    
//    [plistData setObject:value forKey:key];
//    
//    [self writeDataToPlist:plistData];
//    
//    NSLog(@" %@ - %@ ",key, [self getObject:key] );
//}
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
- (NSMutableArray *)getPercentReadArray
{
    //    NSLog(@"stories %@", [self getPlistData]);
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[self getPlistData] objectForKey:@"percentRead"]];
    return array;
    
}
- (NSNumber *)getPercentRead
{
    return [[[[[self getPlistData] objectForKey:@"percentRead"] objectAtIndex:self.manager.currentStorie] objectAtIndex:self.manager.currentChapter] objectAtIndex:self.manager.currentArticle];    
}
- (void)setPercentRead:(NSNumber*)value storie:(NSInteger)storie chapter:(NSInteger)chapter article:(NSInteger)article
{
    
    NSMutableDictionary *plistData = [self getPlistData];
    
    NSMutableArray *percent = [self getObject:@"percentRead"];
    

    [[[percent objectAtIndex:storie] objectAtIndex:chapter] removeObjectAtIndex:article];
    [[[percent objectAtIndex:storie] objectAtIndex:chapter] insertObject:value atIndex:article];
    [plistData setObject:percent forKey:@"percentRead"];
    
    [self writeDataToPlist:plistData];
    
    NSLog(@"Percents %@ ",[self getObject:@"percentRead"]);
    
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
