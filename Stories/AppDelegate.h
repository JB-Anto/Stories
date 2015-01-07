//
//  AppDelegate.h
//  Stories
//
//  Created by LANGLADE Antonin on 10/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAMotionListener.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, JAMotionListenerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) JAMotionListener *motionListener;

@end

