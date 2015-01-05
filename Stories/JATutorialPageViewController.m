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
    UIImage *image = [UIImage imageNamed:[self.dico objectForKey:@"image"]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    float margin;
    if([[self.dico objectForKey:@"custom"]  isEqual: @1]){
        imageView.frame = CGRectMake(self.view.bounds.size.width - 88, 35, image.size.width, image.size.height);
        [self.view addSubview:imageView];
        margin = 0;
    }
    else{
        imageView.frame = CGRectMake(self.view.frame.size.width/2 - image.size.width/2, 0, image.size.width, image.size.height);
        [container addSubview:imageView];
        margin = image.size.height + 20;
    }
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(40, margin, self.view.frame.size.width - 80, 40)];
    title.text = [self.dico objectForKey:@"title"];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:15.0];
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.numberOfLines = 0;
    
    
    if([[self.dico objectForKey:@"button"] isEqual: @1]){
        UIButton *leaveBTN = [[UIButton alloc]initWithFrame:CGRectMake(0, 160, self.view.frame.size.width, 40)];

        leaveBTN.titleLabel.font = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:15.0];
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
        heightGlobal = imageView.frame.size.height + title.frame.size.height + 20;
    }
    container.frame = CGRectMake(0, self.view.frame.size.height/2 - heightGlobal/2, self.view.frame.size.width, heightGlobal);
    

    [container addSubview:title];
    [self.view addSubview:container];
    
}
-(void)leaveView:(UIButton*)sender{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTuto" object:nil];
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
