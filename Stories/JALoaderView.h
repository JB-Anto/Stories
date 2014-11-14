//
//  JALoaderView.h
//  Stories
//
//  Created by Antonin Langlade on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoaderDelegate

-(void)loadNextView;

@end

@interface JALoaderView : UIView

@property (strong,nonatomic) UIView *loader;
@property (strong,nonatomic) UIImageView *imageView;
@property UIGestureRecognizerState stateLoader;

@property (nonatomic, assign) id delegate;

-(void)movePosition:(CGPoint)point;
-(void)setState:(UIGestureRecognizerState)state;

@end
