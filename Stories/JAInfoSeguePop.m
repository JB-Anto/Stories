//
//  JAInfoSeguePop.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 30/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAInfoSeguePop.h"

@implementation JAInfoSeguePop

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    [sourceViewController.navigationController popToViewController:destinationViewController animated:NO];
}

@end
