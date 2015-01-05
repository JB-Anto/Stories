//
//  JAArticleSeguePush.m
//  Stories
//
//  Created by Antonin Langlade on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAArticleSeguePush.h"
#import "JAArticleCollectionViewController.h"

@implementation JAArticleSeguePush

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    JAArticleCollectionViewController *destinationViewController = self.destinationViewController;
    
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
