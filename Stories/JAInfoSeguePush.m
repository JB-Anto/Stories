//
//  JAInfoSeguePush.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 30/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAInfoSeguePush.h"
#import "JAInfoCollectionViewController.h"

@implementation JAInfoSeguePush

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    JAInfoCollectionViewController *destinationViewController = self.destinationViewController;
    
    UIGraphicsBeginImageContextWithOptions(sourceViewController.view.window.bounds.size, YES, 0.0f);
    [sourceViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    destinationViewController.snapshot = snapshot;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    [sourceViewController.navigationController pushViewController:destinationViewController animated:NO];
}

@end
