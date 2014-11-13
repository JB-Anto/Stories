//
//  EMManagerData.m
//  com.gobelins.Estimap
//
//  Created by Antonin Langlade on 26/02/2014.
//  Copyright (c) 2014 Antonin Langlade. All rights reserved.
//

#import "JAManagerData.h"

@implementation JAManagerData

#pragma mark Singleton Methods

+ (id)sharedManager {
    static JAManagerData *myManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myManager = [[self alloc] init];
    });
    return myManager;
}

- (id)init {
    if (self = [super init]) {
        NSLog(@"Init singleton");
      
    }
    return self;
}
//-(UIViewController*)changeGame{
//    UIViewController *viewController;
//    if([self.arrayOfGames count] - 1<= self.currentGame){
//        viewController = [[EMGameQuestionViewController alloc]initWithNibName:@"EMGameQuestionViewController" bundle:nil];
//    }
//    else{
//        self.currentGame += 1;
//        viewController = [[EMHotColdViewController alloc]initWithNibName:@"EMHotColdViewController" bundle:nil];
//
//    }
//    return viewController;
//}

@end
