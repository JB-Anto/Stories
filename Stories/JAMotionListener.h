//
//  JAMotionManager.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 06/01/2015.
//  Copyright (c) 2015 Jb & Anto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol JAMotionListenerDelegate <NSObject>
- (void)deviceDidFlipped;
@end

@interface JAMotionListener : NSObject

@property (assign, nonatomic) id <JAMotionListenerDelegate> delegate;
@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSString *name;

- (id)initWithName:(NSString *)name;
- (void) startListening;
- (void) stopListening;
@end
