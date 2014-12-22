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
#import "JAHeaderCollectionReusableView.h"
#import "JAFooterCollectionReusableView.h"
#import "JAUILabel.h"
#import "JAUITextView.h"
#import "ParallaxFlowLayout.h"

@interface JAArticleCollectionViewController ()
{
    
    CGSize optimalSizeForLabel;
    CGSize maximumSizeOfLabel;
}

@property (strong, nonatomic) UIImage *headerSnapshotFragment;
@property (strong, nonatomic) UIImage *footerSnapshotFragment;

@end

@implementation JAArticleCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Collection View Initialization
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setBounces:NO];
    
    [self setupFollowView];
    self.headerSnapshotFragment = [UIImage imageNamed:@"haut.png"];
    self.footerSnapshotFragment = [UIImage imageNamed:@"bas.png"];

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
    
    // Register cell classes
    [self.collectionView registerClass:[JATitleCollectionViewCell class]      forCellWithReuseIdentifier:@"TitleCell"];
    [self.collectionView registerClass:[JAResumeCollectionViewCell class]     forCellWithReuseIdentifier:@"ResumeCell"];
    [self.collectionView registerClass:[JAParagraphCollectionViewCell class]  forCellWithReuseIdentifier:@"ParagraphCell"];
    [self.collectionView registerClass:[JAImageCollectionViewCell class]      forCellWithReuseIdentifier:@"ImageCell"];
    [self.collectionView registerClass:[JAQuotesCollectionViewCell class]     forCellWithReuseIdentifier:@"QuoteCell"];
    [self.collectionView registerClass:[JAKeyNumberCollectionViewCell class]  forCellWithReuseIdentifier:@"KeyNumberCell"];
    [self.collectionView registerClass:[JACreditCollectionViewCell class]     forCellWithReuseIdentifier:@"CreditsCell"];
    [self.collectionView registerClass:[JAHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
    [self.collectionView registerClass:[JAFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFollowView
{
    _followView = [[JAFollowView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.collectionView.bounds) -75, 35, 40, 40)];
    _followView.delegate = self;
    _followView.backgroundColor = [UIColor clearColor];
    [_followView setColor:[UIColor colorWithHue:0.68 saturation:0.2 brightness:0.54 alpha:1]];
    [self.collectionView addSubview:_followView];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect fixedFrame = self.followView.frame;
    fixedFrame.origin.y = 55 + scrollView.contentOffset.y;
    [self.followView setCenter:CGPointMake(self.followView.center.x, fixedFrame.origin.y)];
    self.followView.centerView = self.followView.center;
}

#pragma mark - JAFollowView Delegate
-(void)followArticle:(BOOL)follow{
    NSLog(@"BOOL Follow %d",follow);
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
    
    UICollectionViewCell *cell = nil;
    
    if(indexPath.item < [self.blocks count]) {
        self.currentBlock = self.blocks[indexPath.item];
        
        if([[self.currentBlock type] isEqualToString:@"title"]) {
            
            JATitleCollectionViewCell *titleCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];
            // Set Content
            // Date out format
            NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
            [dateFormater setDateFormat:@"MMM\u00A0dd"];
            // Date in format
            NSDateFormatter *dateFormaterFromString = [[NSDateFormatter alloc]init];
            [dateFormaterFromString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
            NSDate *date = [dateFormaterFromString dateFromString:[self.currentBlock createdAt]];
            NSString *finalDate = [dateFormater stringFromDate:date];
            [titleCell.titleLabel initWithString:[self.currentBlock title]];
            [titleCell.locationLabel initWithString:[self.currentBlock location]];
            [titleCell.dateLabel initWithString:finalDate];
            [titleCell updateConstraintsIfNeeded];
            cell = titleCell;
            
        } else if([[self.currentBlock type] isEqualToString:@"resume"]) {
                
            JAResumeCollectionViewCell *resumeCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ResumeCell" forIndexPath:indexPath];
            // Set Content
            [resumeCell.resumeLabel initWithString:[self.currentBlock text]];
            resumeCell.idx = [self.resumesID indexOfObject:[self.currentBlock id]];
            [resumeCell addConstraint:[NSLayoutConstraint constraintWithItem:resumeCell.resumeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:resumeCell.contentView attribute:NSLayoutAttributeRight multiplier:0.3 - (0.3-(0.3/(resumeCell.idx+1))) + 0.0000001 constant:0]];
            [resumeCell updateConstraintsIfNeeded];

            cell = resumeCell;
            
        } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            JAParagraphCollectionViewCell *paragraphCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ParagraphCell" forIndexPath:indexPath];
            paragraphCell.paragraphLabel.links = [self.currentBlock links];
            [paragraphCell.paragraphLabel initWithString:[self.currentBlock text]];
            if(self.currentBlock.id.integerValue == self.blocks.count-1) {
                [paragraphCell.paragraphLabel applyMarkOfLastParagraph];
            }
            [paragraphCell updateConstraintsIfNeeded];
            cell = paragraphCell;
            
        } else if([[self.currentBlock type] isEqualToString:@"image"]) {
        
            JAImageCollectionViewCell *imageCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
            //Set Content
            [imageCell.legendLabel initWithString:[self.currentBlock text]];
            [imageCell.imageView setImage:[UIImage imageNamed:[self.currentBlock image]]];
            [imageCell updateConstraintsIfNeeded];
            cell = imageCell;
            
        } else if([[self.currentBlock type] isEqualToString:@"quote"]) {
            
            JAQuotesCollectionViewCell *quoteCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"QuoteCell" forIndexPath:indexPath];
            // Set Content
            [quoteCell.authorLabel initWithString:[self.currentBlock author]];
            [quoteCell.quoteLabel initWithString:[self.currentBlock text]];
            [quoteCell updateConstraintsIfNeeded];
            cell = quoteCell;
            
        } else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
            JAKeyNumberCollectionViewCell *keyNumberCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"KeyNumberCell" forIndexPath:indexPath];
            // Set Content
            [keyNumberCell.numberLabel initWithString:[self.currentBlock number]];
            [keyNumberCell.descriptionLabel initWithString:[self.currentBlock text]];
            [keyNumberCell updateConstraintsIfNeeded];
            cell = keyNumberCell;
            
        }
    } else {
        
        JACreditCollectionViewCell *creditCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CreditsCell" forIndexPath:indexPath];
        // Set Content
        self.creditBlock = self.credits[indexPath.item - [self.blocks count]];
        [creditCell.titleLabel initWithString:[self.creditBlock title]];
        [creditCell.namesLabel initWithString:[[self.creditBlock names] componentsJoinedByString:@"\n"]];
        [creditCell updateConstraintsIfNeeded];
        cell = creditCell;
        
    }
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize sizeOfCell = CGSizeZero;
    
    if(indexPath.item < [self.blocks count]) {
        self.currentBlock = self.blocks[indexPath.item];
        
        if([[self.currentBlock type] isEqualToString:@"title"]) {
            
            JATitleCollectionViewCell *cell = [JATitleCollectionViewCell new];
            [cell.titleLabel  initWithString:[self.currentBlock title]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right;
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.titleLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"resume"]) {

            JAResumeCollectionViewCell *cell = [JAResumeCollectionViewCell new];
            [cell.resumeLabel  initWithString:[self.currentBlock text]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
            maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            JAParagraphCollectionViewCell *cell = [JAParagraphCollectionViewCell new];
            cell.paragraphLabel.links = [self.currentBlock links];
            [cell.paragraphLabel initWithString:[self.currentBlock text]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.paragraphLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"image"]) {
            
            UIImage *image = [UIImage imageNamed:[self.currentBlock image]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
            sizeOfCell = CGSizeMake(cellWidth, image.size.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"quote"]) {
        
            JAQuotesCollectionViewCell *cell = [JAQuotesCollectionViewCell new];
            [cell.quoteLabel initWithString:[self.currentBlock text]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right - 40);
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.quoteLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
        
            JAKeyNumberCollectionViewCell *cell = [JAKeyNumberCollectionViewCell new];
            [cell.numberLabel initWithString:[self.currentBlock number]];
            ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
            CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right - 40);
            maximumSizeOfLabel = CGSizeMake(195, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.numberLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        }
    } else {

        JACreditCollectionViewCell *cell = [JACreditCollectionViewCell new];
        self.creditBlock = self.credits[indexPath.item - [self.blocks count]];
        [cell.titleLabel initWithString:[self.creditBlock title]];
        [cell.namesLabel initWithString:[[self.creditBlock names] componentsJoinedByString:@"\n"]];
        ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
        CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds)/2 - layout.sectionInset.left/4 - layout.sectionInset.right);
        CGFloat cellHeight = CGRectGetHeight(cell.titleLabel.bounds) + CGRectGetHeight(cell.namesLabel.bounds);
        sizeOfCell = CGSizeMake(cellWidth, cellHeight);
        
    }
    
    return sizeOfCell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableView = nil;
    
    if(kind == UICollectionElementKindSectionHeader) {
        
        JAHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
        [headerView.backgroundImageView setImage:self.headerSnapshotFragment];
        [headerView updateConstraintsIfNeeded];
        reusableView = headerView;
        
    } else if (kind == UICollectionElementKindSectionFooter) {
        
        JAFooterCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView" forIndexPath:indexPath];
        [footerView.backgroundImageView setImage:self.footerSnapshotFragment];
        reusableView = footerView;
        
    }
    
    return reusableView;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    UIImage *image = self.headerSnapshotFragment;
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), image.size.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    UIImage *image = self.footerSnapshotFragment;
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), image.size.height);
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
