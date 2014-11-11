//
//  JACoverViewController.h
//  Stories
//
//  Created by LANGLADE Antonin on 10/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SwitchCoverProtocol <NSObject>

@optional
-(void)changeViewController;

@end

@interface JACoverViewController : UIPageViewController
@property (weak, nonatomic) id<SwitchCoverProtocol> delegate;

@end
