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
#import "JAManagerData.h"

@protocol JAUITextViewDelegate <NSObject>
- (void)linkDidPressed;
@end



@interface JAUITextView : CCHLinkTextView <CCHLinkTextViewDelegate>
@property CGFloat lineHeight;
@property CGFloat letterSpacing;
@property (strong, nonatomic) UIColor *linkColor;
@property (strong, nonatomic) NSArray *links;
@property (assign) id <JAUITextViewDelegate> delegate;
@property (strong, nonatomic) JAManagerData *manager;

-(void)initWithString:(NSString *)text;
-(void)addLink;
-(void)applyLineHeight;
-(void)applyLetterSpacing;
-(void)applyMarkOfLastParagraph;
@end
