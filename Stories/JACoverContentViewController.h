//
//  JACoverContentViewController.h
//  Stories
//
//  Created by Antonin Langlade on 10/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JACoverViewController.h"

@interface JACoverContentViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UILabel *placesLBL;
@property (weak, nonatomic) IBOutlet UILabel *titleLBL;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end