//
//  JACoverCollectionViewController.h
//  Stories
//
//  Created by LANGLADE Antonin on 12/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JACoverCollectionViewCell.h"

typedef NS_ENUM(NSInteger, JAAnimDirection) {
    JAAnimDirectionLeft,
    JAAnimDirectionRight
};

@interface JACoverCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property int currentIndex;

@end
