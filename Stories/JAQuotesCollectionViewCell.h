//
//  QuotesCollectionViewCell.h
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JAQuotesCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *quotesLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@end
