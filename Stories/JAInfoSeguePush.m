//
//  JAInfoSeguePush.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 30/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAInfoSeguePush.h"

@implementation JAInfoSeguePush

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
}

@end
