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
    }
    return self;
}

#pragma mark - User info value handlers

- (NSString *)getCoverFollow:(NSString*)follow
{
    NSLog(@"stories %@", [self getPlistData]);
    return [[[self getPlistData] objectForKey:@"cover"] objectForKey:follow];

}

- (void)setCoverFollowing:(NSString *)key value:(NSString *)value
{
    NSMutableDictionary *plistData = [self getPlistData];
    
    [[plistData objectForKey:@"cover"] setObject:value forKey:key];
    
    [self writeDataToPlist:plistData];
    
    NSLog(@" %@ - %@ ",key, [self getCoverFollow:key] );

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
