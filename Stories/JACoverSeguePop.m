//
//  JACoverSeguePop.m
//  Stories
//
//  Created by Antonin Langlade on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACoverSeguePop.h"

@implementation JACoverSeguePop

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    


    [sourceViewController.navigationController popToViewController:destinationViewController animated:NO];
}

@end
