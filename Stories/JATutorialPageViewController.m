//
//  JATutorialPageViewController.m
//  Stories
//
//  Created by LANGLADE Antonin on 05/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import "JATutorialPageViewController.h"

@interface JATutorialPageViewController ()

@end

@implementation JATutorialPageViewController

-(id)init:(NSDictionary*)dico{
    self = [super init];
    
    if(self)
    {
        self.dico = dico;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *container = [[UIView alloc]init];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:[self.dico objectForKey:@"image"],0]];
    self.imageView = [[UIImageView alloc]init];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < [[self.dico objectForKey:@"numberImage"] integerValue]; i++) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:[self.dico objectForKey:@"image"],i]]];
    }
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 160.0, 160.0)];
    [self.imageView setAnimationImages:images];
    [self.imageView setAnimationRepeatCount:1];
    [self.imageView setAnimationDuration:2.0];

    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:[self.dico objectForKey:@"image"],[[self.dico objectForKey:@"numberImage"] integerValue] - 1]];
    
    float margin;
    if([[self.dico objectForKey:@"custom"]  isEqual: @1]){
        self.imageView.frame = CGRectMake(self.view.bounds.size.width - 88, 35, image.size.width, image.size.height);
        [self.view addSubview:self.imageView];
        margin = 0;
    }
    else{
        self.imageView.frame = CGRectMake(self.view.frame.size.width/2 - image.size.width/2, 0, image.size.width, image.size.height);
        [container addSubview:self.imageView];
        margin = image.size.height + 20;
    }
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(40, margin, self.view.frame.size.width - 80, 80)];
    title.text = [self.dico objectForKey:@"title"];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:23.0];
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.numberOfLines = 0;
    
    
    if([[self.dico objectForKey:@"button"] isEqual: @1]){
        UIButton *leaveBTN = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 160, self.view.frame.size.width, 40)];

        leaveBTN.titleLabel.font = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:23.0];
        leaveBTN.titleLabel.textColor = [UIColor whiteColor];
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:@"Got it!"];
        [titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [titleString length])];
        // using text on button
        [leaveBTN setAttributedTitle: titleString forState:UIControlStateNormal];
        
        [leaveBTN addTarget:self action:@selector(leaveView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:leaveBTN];
    }
    
    float heightGlobal;
    if([[self.dico objectForKey:@"custom"]  isEqual: @1]){
        heightGlobal = title.frame.size.height;
    }
    else{
        heightGlobal = self.imageView.frame.size.height + title.frame.size.height + 20;
    }
    container.frame = CGRectMake(0, self.view.frame.size.height/2 - heightGlobal/2, self.view.frame.size.width, heightGlobal);
    

    [container addSubview:title];
    [self.view addSubview:container];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.imageView startAnimating];
}
-(void)leaveView:(UIButton*)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTuto" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
