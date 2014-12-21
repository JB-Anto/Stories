//
//  JACoverSeguePush.m
//  Stories
//
//  Created by Antonin Langlade on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACoverSeguePush.h"

@implementation JACoverSeguePush

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    
    
    [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
}

@end
