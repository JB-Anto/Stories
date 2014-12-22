//
//  JAInfoCollectionViewController.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 21/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAInfoCollectionViewController.h"
#import "ParallaxFlowLayout.h"
#import "JANumberTitleCollectionViewCell.h"
#import "JAPortraitTitleCollectionViewCell.h"
#import "JAParagraphCollectionViewCell.h"
#import "JAResumeCollectionViewCell.h"
#import "JAHeaderCollectionReusableView.h"
#import "JAFooterCollectionReusableView.h"
#import "JAUILabel.h"
#import "JAUITextView.h"

@interface JAInfoCollectionViewController ()
{

    CGSize optimalSizeForLabel;
    CGSize maximumSizeOfLabel;

}

@property (strong, nonatomic) JABlockModel *currentBlock;
@property (strong, nonatomic) NSMutableArray *resumesID;
@property (strong, nonatomic) UIImage *headerSnapshotFragment;
@property (strong, nonatomic) UIImage *footerSnapshotFragment;

@end

@implementation JAInfoCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // CollectionView Initialization
    [self.collectionView setBackgroundColor:[UIColor colorWithHue:0 saturation:0 brightness:0.97 alpha:1]];
    [self.collectionView setBounces:NO];
    [self setupHeaderView];
    [self setupFollowView];
    self.headerSnapshotFragment = [UIImage imageNamed:@"hautBlank.png"];
    self.footerSnapshotFragment = [UIImage imageNamed:@"basBlank.png"];
    
    // Data Management
    self.manager = [JAManagerData sharedManager];
    self.manager.currentStorie = 0;
    self.manager.currentChapter = 0;
    self.manager.currentArticle = 4;
    self.manager.currentInfo = 0;
    
    JAInfoModel *info = [self.manager getCurrentInfo];
    self.blocks = [info blocks];
    // NSArray of each resume block ids
    self.resumesID = [NSMutableArray new];
    for(int i=0; i<[_blocks count]; i++) {
        self.currentBlock = _blocks[i];
        if([[self.currentBlock type] isEqualToString:@"resume"]) {
            [self.resumesID addObject:[self.currentBlock id]];
        }
    }
    
    // Register cell classes
    [self.collectionView registerClass:[JANumberTitleCollectionViewCell class] forCellWithReuseIdentifier:@"NumberTitleCell"];
    [self.collectionView registerClass:[JAPortraitTitleCollectionViewCell class] forCellWithReuseIdentifier:@"PortraitTitleCell"];
    [self.collectionView registerClass:[JAParagraphCollectionViewCell class] forCellWithReuseIdentifier:@"ParagraphCell"];
    [self.collectionView registerClass:[JAResumeCollectionViewCell class] forCellWithReuseIdentifier:@"ResumeCell"];
    [self.collectionView registerClass:[JAHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"];
    [self.collectionView registerClass:[JAFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupHeaderView {
    
    
    
}

- (void)setupFollowView {
    
    _followView = [[JAFollowView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.collectionView.bounds) -75, 35, 40, 40)];
    _followView.delegate = self;
    _followView.backgroundColor = [UIColor clearColor];
    [_followView setColor:[UIColor colorWithHue:0.68 saturation:0.2 brightness:0.54 alpha:1]];
    [self.collectionView addSubview:_followView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect fixedFrame = self.followView.frame;
    fixedFrame.origin.y = 55 + scrollView.contentOffset.y;
    [self.followView setCenter:CGPointMake(self.followView.center.x, fixedFrame.origin.y)];
    self.followView.centerView = self.followView.center;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - JAFollowView Delegate
-(void)followArticle:(BOOL)follow {
    NSLog(@"BOOL Follow %d",follow);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.blocks count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = nil;
    
    self.currentBlock = self.blocks[indexPath.item];
    
    if([[self.currentBlock type] isEqualToString:@"titlePortrait"]) {
        
        JAPortraitTitleCollectionViewCell *titleCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PortraitTitleCell" forIndexPath:indexPath];
        [titleCell.portraitImageView setImage:[UIImage imageNamed:[self.currentBlock image]]];
        NSString *name = [[self.currentBlock text] stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
        [titleCell.nameLabel setText:name];
        [titleCell updateConstraintsIfNeeded];
        cell = titleCell;
        
    } else if([[self.currentBlock type] isEqualToString:@"titleNumber"]) {
        
        JANumberTitleCollectionViewCell *titleCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"NumberTitleCell" forIndexPath:indexPath];
        [titleCell.numberLabel initWithString:[self.currentBlock number]];
        [titleCell.textLabel initWithString:[self.currentBlock text]];
        [titleCell updateConstraintsIfNeeded];
        cell = titleCell;
    
    } else if([[self.currentBlock type] isEqualToString:@"resume"]) {
        
        JAResumeCollectionViewCell *resumeCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ResumeCell" forIndexPath:indexPath];
        // Set Content
        [resumeCell.resumeLabel initWithString:[self.currentBlock text]];
        resumeCell.idx = [self.resumesID indexOfObject:[self.currentBlock id]];
        [resumeCell addConstraint:[NSLayoutConstraint constraintWithItem:resumeCell.resumeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:resumeCell.contentView attribute:NSLayoutAttributeRight multiplier:0.3 - (0.3-(0.3/(resumeCell.idx+1))) + CGFLOAT_MIN constant:0]];
        [resumeCell updateConstraintsIfNeeded];
        
        cell = resumeCell;
        
    } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
        
        JAParagraphCollectionViewCell *paragraphCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ParagraphCell" forIndexPath:indexPath];
        [paragraphCell.paragraphLabel initWithString:[self.currentBlock text]];
        [paragraphCell updateConstraintsIfNeeded];
        cell = paragraphCell;
        
    }
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // CGSizeZero not allowed
    CGSize sizeOfCell = CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
    self.currentBlock = self.blocks[indexPath.item];
    ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
    CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
    
    if([[self.currentBlock type] isEqualToString:@"titleNumber"]) {
        
        JANumberTitleCollectionViewCell *cell = [JANumberTitleCollectionViewCell new];
        [cell.textLabel initWithString:[self.currentBlock text]];
        maximumSizeOfLabel = CGSizeMake(cellWidth*0.9, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.textLabel sizeThatFits:maximumSizeOfLabel];
        sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height+20);
        
    } else if([[self.currentBlock type] isEqualToString:@"titlePortrait"]) {
        
        UIImage *image = [UIImage imageNamed:[self.currentBlock image]];
        sizeOfCell = CGSizeMake(cellWidth, image.size.height);
        
    } else if([[self.currentBlock type] isEqualToString:@"resume"]) {
        
        JAResumeCollectionViewCell *cell = [JAResumeCollectionViewCell new];
        [cell.resumeLabel initWithString:[self.currentBlock text]];
        maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];
        sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
        
    } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
        
        JAParagraphCollectionViewCell *cell = [JAParagraphCollectionViewCell new];
        [cell.paragraphLabel initWithString:[self.currentBlock text]];
        maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.paragraphLabel sizeThatFits:maximumSizeOfLabel];
        sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
        
    }
    
    return sizeOfCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    UIImage *image = self.headerSnapshotFragment;
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), image.size.height);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    UIImage *image = self.footerSnapshotFragment;
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), image.size.height);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
