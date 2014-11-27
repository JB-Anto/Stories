//
//  ImageCollectionViewCell.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAImageCollectionViewCell.h"

@implementation JAImageCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:self.frame]) {
//        NSLog(@"Init imageCell");
        
        // For better perfomance
        [self setOpaque:NO];
        
        // Main characteristics of labels in the view
        UIFont *paragraphFont = [UIFont fontWithName:@"News-Plantin-Pro-Regular-Italic" size:13.0];
        UIColor *paragraphColor = [UIColor colorWithHue:0.68 saturation:0.45 brightness:0.34 alpha:1];
        
        // Initial Setting - Resume Label
        self.legendLabel = [JAUILabel new];
        [self.legendLabel setNumberOfLines:0];
        [self.legendLabel setFont:paragraphFont];
        [self.legendLabel setTextColor:paragraphColor];
        
        self.imageView = [UIImageView new];
        [self.imageView setAlpha:.4];
        
        // User Interaction on imageView
        self.imageView.userInteractionEnabled = YES;
        UISwipeGestureRecognizer *recognizer = [UISwipeGestureRecognizer new];
        UISwipeGestureRecognizer *recognizer2 = [UISwipeGestureRecognizer new];
        
        
        //pgr.delegate = self;
        //[self.imageView addGestureRecognizer:pgr];
        
        recognizer.delegate = self;
        
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self.imageView addGestureRecognizer:recognizer];
        
        recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self.imageView addGestureRecognizer:recognizer];

        
        
        // Ready to add in parent view
        [self addSubview:self.imageView];
        [self addSubview:self.legendLabel];
        
        // ********TEMPORARY********
//        [self.imageView setBackgroundColor:[UIColor redColor]];
//        [self.legendLabel setBackgroundColor:[UIColor redColor]];
//        [self setBackgroundColor:[UIColor greenColor]];
        
    }
    
    return self;
    
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)gesture
{
    
    NSLog(@"Swipe");
    
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.imageView.center = CGPointMake(self.center.x, self.imageView.center.y);;
            self.imageView.alpha = 1.0;
            self.imageView.transform = CGAffineTransformMakeScale(1.4, 1.4);
            
            self.legendLabel.center = CGPointMake(self.legendLabel.bounds.size.width/2, self.legendLabel.center.y);
            self.legendLabel.alpha = 0.1;
            
        }];
    }
    
    
    if ((gesture.direction == UISwipeGestureRecognizerDirectionLeft)) {
        
        [UIView animateWithDuration:0.4 animations:^{
            self.imageView.center = CGPointMake(self.imageView.bounds.size.width/2, self.imageView.center.y);
            self.imageView.alpha = 0.4;
            self.imageView.transform = CGAffineTransformMakeScale(1, 1);
            
            self.legendLabel.center = CGPointMake((self.imageView.bounds.size.width*0.65) + self.legendLabel.bounds.size.width/2, self.legendLabel.center.y);
            self.legendLabel.alpha = 1;
        }];
    }
    
}
@end
