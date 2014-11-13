//
//  ViewController.m
//  Stories
//
//  Created by LANGLADE Antonin on 10/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "ViewController.h"
#import "JAChapterTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JAChapterTableViewController *chapterTableViewController;
    
    [self.view addSubview:chapterTableViewController.ArticlesTableView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
