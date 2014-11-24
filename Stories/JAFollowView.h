//
//  JAFollowView.h
//  Stories
//
//  Created by LANGLADE Antonin on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoaderDelegate

-(void)followArticle;

@end

@interface JAFollowView : UIView

@property (nonatomic, assign) id delegate;

typedef NS_ENUM(NSInteger, JAAnimationEntry) {
    JAAnimEntryIn,
    JAAnimEntryOut
};

-(void)rotateSquare:(float)angle;
-(void)validateFollow;
-(void)unValidateFollow;

@end
