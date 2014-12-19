//
//  ArticleCollectionViewController.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAArticleCollectionViewController.h"
#import "JATitleCollectionViewCell.h"
#import "JAResumeCollectionViewCell.h"
#import "JAParagraphCollectionViewCell.h"
#import "JAImageCollectionViewCell.h"
#import "JAQuotesCollectionViewCell.h"
#import "JAKeyNumberCollectionViewCell.h"
#import "JACreditCollectionViewCell.h"
#import "JAUILabel.h"
#import "JAUITextView.h"
#import "ParallaxFlowLayout.h"

@interface JAArticleCollectionViewController ()
{
    
    CGSize optimalSizeForLabel;
    CGSize maximumSizeOfLabel;
    
}
@end

@implementation JAArticleCollectionViewController

- (id)init
{
    ParallaxFlowLayout *layout = [ParallaxFlowLayout new];
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    self = [super initWithCollectionViewLayout:layout];
    if(self == nil) {
        return nil;
    }
    self.title = @"Article";
    // DATA Management
    self.manager = [JAManagerData sharedManager];
    self.manager.currentStorie  = 0;
    self.manager.currentChapter = 0;
    self.manager.currentArticle = 4;
    JAArticleModel *article = [self.manager getCurrentArticle];
    self.blocks = [article blocks];
    self.credits = [article credits];
    // NSArray of each resume block ids
    self.resumesID = [NSMutableArray new];
    for(int i=0; i<[_blocks count]; i++) {
        self.currentBlock = _blocks[i];
        if([[self.currentBlock type] isEqualToString:@"resume"]) {
            [self.resumesID addObject:[self.currentBlock id]];
        }
    }
    return self;
    
}

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    return [self init];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    // Register cell classes
    [self.collectionView registerClass:[JATitleCollectionViewCell class]     forCellWithReuseIdentifier:@"TitleCell"];
    [self.collectionView registerClass:[JAResumeCollectionViewCell class]    forCellWithReuseIdentifier:@"ResumeCell"];
    [self.collectionView registerClass:[JAParagraphCollectionViewCell class] forCellWithReuseIdentifier:@"ParagraphCell"];
    [self.collectionView registerClass:[JAImageCollectionViewCell class]     forCellWithReuseIdentifier:@"ImageCell"];
    [self.collectionView registerClass:[JAQuotesCollectionViewCell class]    forCellWithReuseIdentifier:@"QuoteCell"];
    [self.collectionView registerClass:[JAKeyNumberCollectionViewCell class] forCellWithReuseIdentifier:@"KeyNumberCell"];
    [self.collectionView registerClass:[JACreditCollectionViewCell class]    forCellWithReuseIdentifier:@"CreditsCell"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger numberOfSection = [self.blocks count];
    
    if(self.credits) {
        numberOfSection += [self.credits count];
    }
    
    return numberOfSection;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.item < [self.blocks count]) {
        self.currentBlock = self.blocks[indexPath.item];
        
        if([[self.currentBlock type] isEqualToString:@"title"]) {
            
            JATitleCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];
            // Set Content
            // Date out format
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
            [dateFormater setDateFormat:@"MMM\u00A0dd"];
            // Date in format
            NSDateFormatter *dateFormaterFromString = [[NSDateFormatter alloc]init];
            [dateFormaterFromString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
            NSDate *date = [dateFormaterFromString dateFromString:[self.currentBlock createdAt]];
            NSString *finalDate = [dateFormater stringFromDate:date];
            [cell.titleLabel initWithString:[self.currentBlock title]];
            [cell.locationLabel initWithString:[self.currentBlock location]];
            [cell.dateLabel initWithString:finalDate];
            [cell updateConstraintsIfNeeded];
            return cell;
            
        } else if([[self.currentBlock type] isEqualToString:@"resume"]) {
                
            JAResumeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ResumeCell" forIndexPath:indexPath];
            // Set Content
            [cell.resumeLabel initWithString:[self.currentBlock text]];
            cell.idx = [self.resumesID indexOfObject:[self.currentBlock id]];
            [cell addConstraint:[NSLayoutConstraint constraintWithItem:cell.resumeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeRight multiplier:0.3 - (0.3-(0.3/(cell.idx+1))) + 0.0000001 constant:0]];
            [cell updateConstraintsIfNeeded];

            return cell;
            
        } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            JAParagraphCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ParagraphCell" forIndexPath:indexPath];
            cell.paragraphLabel.links = [self.currentBlock links];
            [cell.paragraphLabel initWithString:[self.currentBlock text]];
            [cell updateConstraintsIfNeeded];
            return cell;
            
        } else if([[self.currentBlock type] isEqualToString:@"image"]) {
        
            JAImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
            //Set Content
            [cell.legendLabel initWithString:[self.currentBlock text]];
            [cell.imageView setImage:[UIImage imageNamed:[self.currentBlock image]]];
            [cell updateConstraintsIfNeeded];
            return cell;
            
        } else if([[self.currentBlock type] isEqualToString:@"quote"]) {
            
            JAQuotesCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"QuoteCell" forIndexPath:indexPath];
            // Set Content
            [cell.authorLabel initWithString:[self.currentBlock author]];
            [cell.quoteLabel initWithString:[self.currentBlock text]];
            [cell updateConstraintsIfNeeded];
            return cell;
            
        } else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
            JAKeyNumberCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"KeyNumberCell" forIndexPath:indexPath];
            // Set Content
            [cell.numberLabel initWithString:[self.currentBlock number]];
            [cell.descriptionLabel initWithString:[self.currentBlock text]];
            [cell updateConstraintsIfNeeded];
            return cell;
            
        } else {
             
            return nil;
             
        }
    } else {
        
        JACreditCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CreditsCell" forIndexPath:indexPath];
        // Set Content
        self.creditBlock = self.credits[indexPath.item - [self.blocks count]];
        [cell.titleLabel initWithString:[self.creditBlock title]];
        [cell.namesLabel initWithString:[[self.creditBlock names] componentsJoinedByString:@"\n"]];
        [cell updateConstraintsIfNeeded];
        return cell;
        
    }
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.item < [self.blocks count]) {
        self.currentBlock = self.blocks[indexPath.item];
        
        if([[self.currentBlock type] isEqualToString:@"title"]) {
            
            JATitleCollectionViewCell *cell = [JATitleCollectionViewCell new];
            [cell.titleLabel  initWithString:[self.currentBlock title]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right;
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.titleLabel sizeThatFits:maximumSizeOfLabel];
            return CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"resume"]) {

            JAResumeCollectionViewCell *cell = [JAResumeCollectionViewCell new];
            [cell.resumeLabel  initWithString:[self.currentBlock text]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
            maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];
            return CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            JAParagraphCollectionViewCell *cell = [JAParagraphCollectionViewCell new];
            cell.paragraphLabel.links = [self.currentBlock links];
            [cell.paragraphLabel initWithString:[self.currentBlock text]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.paragraphLabel sizeThatFits:maximumSizeOfLabel];
            return CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"image"]) {
            
            UIImage *image = [UIImage imageNamed:[self.currentBlock image]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
            return CGSizeMake(cellWidth, image.size.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"quote"]) {
        
            JAQuotesCollectionViewCell *cell = [JAQuotesCollectionViewCell new];
            [cell.quoteLabel initWithString:[self.currentBlock text]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right - 40);
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.quoteLabel sizeThatFits:maximumSizeOfLabel];
            return CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
        
            JAKeyNumberCollectionViewCell *cell = [JAKeyNumberCollectionViewCell new];
            [cell.numberLabel initWithString:[self.currentBlock number]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right - 40);
            maximumSizeOfLabel = CGSizeMake(195, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.numberLabel sizeThatFits:maximumSizeOfLabel];
            return CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else {
            // CGSizeZero not allowed...
            return CGSizeMake(1, 1);
        }
    } else {

        JACreditCollectionViewCell *cell = [JACreditCollectionViewCell new];
        self.creditBlock = self.credits[indexPath.item - [self.blocks count]];
        [cell.titleLabel initWithString:[self.creditBlock title]];
        [cell.namesLabel initWithString:[[self.creditBlock names] componentsJoinedByString:@"\n"]];
        ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
        CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds)/2 - layout.sectionInset.left/4 - layout.sectionInset.right);
        CGFloat cellHeight = CGRectGetHeight(cell.titleLabel.bounds) + CGRectGetHeight(cell.namesLabel.bounds);
        return CGSizeMake(cellWidth, cellHeight);
        
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
