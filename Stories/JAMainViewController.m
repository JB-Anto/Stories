//
//  MainViewController.m
//  Stories
//
//  Created by Antonin Langlade on 10/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAMainViewController.h"

@interface JAMainViewController ()

@end

@implementation JAMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create the data model
//    self.coverModel = [NSMutableArray arrayWithArray:[JSONFetcher getArrayFromJson:@"cover"]];
//    NSLog(@"Array : %@",[JSONFetcher getArrayFromJson:@"cover"]);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"TestNotification"
                                               object:nil];


}
- (void) receiveTestNotification:(NSNotification *) notification
{
    
    if ([[notification name] isEqualToString:@"TestNotification"])
    {
        NSLog(@"CHANGGGED ");
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
