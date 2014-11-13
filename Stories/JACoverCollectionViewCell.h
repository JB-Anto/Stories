//
//  JACoverCollectionViewCell.h
//  Stories
//
//  Created by LANGLADE Antonin on 12/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JACoverCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (strong, nonatomic) IBOutlet UILabel *placesLBL;


-(void)animateEnter;
-(void)resetAnimation;

@end
