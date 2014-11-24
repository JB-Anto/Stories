//
//  JALoaderView.m
//  Stories
//
//  Created by Antonin Langlade on 13/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JALoaderView.h"

@implementation JALoaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
        self.loader = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 160, 160)];
        
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 0; i < 40; i++) {
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loader_%i.png",i]]];
        }
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 160.0, 160.0)];
        [self.imageView setAnimationImages:images];
        [self.imageView setAnimationRepeatCount:1];
        [self.imageView setAnimationDuration:2];

        [self.loader addSubview:self.imageView];
        [self addSubview:self.loader];
        
    }
    
    return self;
    
}
-(void)movePosition:(CGPoint)point{
    self.loader.center = point;
}

-(void)setState:(UIGestureRecognizerState)state{
    if(self.stateLoader != state){
        self.stateLoader = state;
    }
    
    if(self.stateLoader == UIGestureRecognizerStateEnded){
        [self.imageView stopAnimating];
    }
    else if(self.stateLoader == UIGestureRecognizerStateBegan){
        [self.imageView startAnimating];
        [self performSelector:@selector(loadNextView ) withObject:nil
                   afterDelay:self.imageView.animationDuration];
    }
}
-(void)loadNextView{
    if(self.stateLoader == UIGestureRecognizerStateChanged || self.stateLoader == UIGestureRecognizerStateBegan){
        NSLog(@"Chapters");
        [self.delegate loadNextView];
    }
}


@end
