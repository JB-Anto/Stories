//
//  JAFollowView.h
//  Stories
//
//  Created by LANGLADE Antonin on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FollowDelegate

-(void)followArticle:(BOOL)follow;

@end

@interface JAFollowView : UIView

typedef NS_ENUM(NSInteger, JAAnimationEntry) {
    JAAnimEntryIn,
    JAAnimEntryOut,
    JAAnimEntryNone
};

@property BOOL validate;
@property (nonatomic, assign) id delegate;
@property (nonatomic) CGPoint centerView;
@property JAAnimationEntry lastEntry;

-(void)rotateSquare:(float)angle;
-(void)setColor:(UIColor *)color;
-(void)validateFollow;
-(void)unValidateFollow;
-(void)animationBorder:(JAAnimationEntry)entry;


@end
