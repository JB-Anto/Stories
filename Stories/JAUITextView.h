//
//  JATextView.h
//  Stories
//
//  Created by Jean-baptiste PENRATH on 27/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCHLinkTextView.h"
#import "CCHLinkTextViewDelegate.h"
#import "CCHLinkGestureRecognizer.h"


@interface JAUITextView : CCHLinkTextView <CCHLinkTextViewDelegate>
@property CGFloat lineHeight;
@property CGFloat letterSpacing;
@property (strong, nonatomic) UIColor *linkColor;
@property (strong, nonatomic) NSArray *links;

-(void)initWithString:(NSString *)text;
-(void)initWithStringToFormat:(NSString *)text;
-(void)addLink;
-(void)applyLineHeight;
-(void)applyLetterSpacing;
@end
