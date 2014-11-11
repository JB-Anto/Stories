//
//  JACoverContentViewController.m
//  Stories
//
//  Created by Antonin Langlade on 10/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACoverContentViewController.h"

@interface JACoverContentViewController ()

@end

@implementation JACoverContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundIV.image = [UIImage imageNamed:self.imageFile];
    //self.placesLBL.text = self.titleText;
    self.titleLBL.text = self.titleText;
    self.titleLBL.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLBL.numberOfLines = 2;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushButton:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"TestNotification"
     object:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
