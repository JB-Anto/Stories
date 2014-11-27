//
//  JAArticleSeguePush.m
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAArticleSeguePush.h"

@implementation JAArticleSeguePush

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    
    
    [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
}

@end
