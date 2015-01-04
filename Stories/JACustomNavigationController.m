//
//  JACustomNavigationController.m
//  Stories
//
//  Created by Antonin Langlade on 25/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JACustomNavigationController.h"

@interface JACustomNavigationController ()

@end

@implementation JACustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {
    
    UIStoryboardSegue *segue = nil;
    
    // Instantiate a new CustomUnwindSegue
    if([identifier isEqualToString:@"JACoverPop"]){
        JACoverSeguePop *coverSegue = [[JACoverSeguePop alloc] initWithIdentifier:@"JACoverPop" source:fromViewController destination:toViewController];
        segue = coverSegue;
    }
    else if([identifier isEqualToString:@"JAArticlePop"]) {
        JAArticleSeguePop *articleSegue = [[JAArticleSeguePop alloc] initWithIdentifier:@"JAArticlePop" source:fromViewController destination:toViewController];
        segue = articleSegue;
    }
    else if([identifier isEqualToString:@"JAInfoPop"]) {
        JAInfoSeguePop *infoSegue = [[JAInfoSeguePop alloc] initWithIdentifier:@"JAInfoPop" source:fromViewController destination:toViewController];
        segue = infoSegue;
    }
    
    return segue;
    
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
