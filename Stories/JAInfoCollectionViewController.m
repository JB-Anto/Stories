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
#import "JAHeaderView.h"
#import "JAFooterView.h"
#import "JAUILabel.h"
#import "JAUITextView.h"
#import "PocketSVG.h"

@interface JAInfoCollectionViewController ()
{

    CGSize optimalSizeForLabel;
    CGSize maximumSizeOfLabel;

}

@property (strong, nonatomic) JABlockModel *currentBlock;
@property (strong, nonatomic) NSMutableArray *resumesID;

@end

@implementation JAInfoCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // CollectionView Initialization
    [self.collectionView setBackgroundColor:[UIColor colorWithHue:0 saturation:0 brightness:0.97 alpha:1]];

    // Data Management
    self.manager = [JAManagerData sharedManager];
    
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
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.delegate = self;
    [self.view addGestureRecognizer:doubleTapGesture];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupHeaderView];
    [self setupFooterView];
    [self setupFollowView];
}

-(void)doubleTap:(UITapGestureRecognizer*)sender{
    //       NSLog(@"Percent Scroll %f",self.articleCollectionView.contentOffset.y / (self.articleCollectionView.contentSize.height - scrollView.frame.size.height)  * 100);
    [self performSegueWithIdentifier:@"JAInfoPop" sender:self];
    //    Method to go to cover width flip
    //    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupHeaderView {
    self.headerView = [[JAHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds))];
    [self.headerView setImage:self.snapshot];
    [self.headerView updateConstraintsIfNeeded];
//    [self.collectionView addSubview:self.headerView];
    
    // Mask
    CGPathRef maskPath = [PocketSVG pathFromSVGFileNamed:@"top"];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath;
    if(IS_IPHONE_6){
        maskLayer.transform = CATransform3DMakeScale(1.175, 1.175, 1);
    }
    else if(IS_IPHONE_6P){
        maskLayer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
    }
    
    self.headerView.layer.mask = maskLayer;
    [self.collectionView addSubview:self.headerView];
    [self.headerView animateEnter];
    
}

- (void)setupFooterView {
    CGFloat collectionViewHeight = self.collectionViewLayout.collectionViewContentSize.height;
    self.footerView = [[JAFooterView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds))];
    [self.footerView setImage:self.snapshot];
    [self.footerView updateConstraintsIfNeeded];
    
    //Mask
    CGPathRef maskPath = [PocketSVG pathFromSVGFileNamed:@"bottom"];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath;
    if(IS_IPHONE_6){
        maskLayer.transform = CATransform3DMakeScale(1.175, 1.175, 1);
    }
    else if(IS_IPHONE_6P){
        maskLayer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
    }
    self.footerView.layer.mask = maskLayer;
    [self.collectionView addSubview:self.footerView];
    [self.footerView animateEnterWithValue:collectionViewHeight];
    
}

- (void)setupFollowView {
    
    _followView = [[JAFollowView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.collectionView.bounds) -75, 35, 40, 40)];
    _followView.delegate = self;
    _followView.backgroundColor = [UIColor clearColor];
    [_followView setColor:[UIColor colorWithHue:0.68 saturation:0.2 brightness:0.54 alpha:1]];
    [self.collectionView addSubview:_followView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // Header "Parallax Effect"
    CGPoint headerCenter = self.headerView.center;
    if(scrollView.contentOffset.y < 150) {
        headerCenter.y = self.headerView.initialCenter.y + scrollView.contentOffset.y*0.5;
        [self.headerView setCenter:CGPointMake(self.headerView.center.x, headerCenter.y)];
    }
    
    // Footer "Parallax Effect"
    CGPoint footerCenter = self.footerView.center;
    CGFloat maxScroll = scrollView.contentSize.height - scrollView.bounds.size.height;

    if(maxScroll - scrollView.contentOffset.y < 28) {
        footerCenter.y = self.footerView.initialCenter.y + (maxScroll - scrollView.contentOffset.y);
        [self.footerView setCenter:CGPointMake(self.footerView.center.x, footerCenter.y)];
    }
    
    // Follow View fixed position
    CGPoint followViewCenter = self.followView.center;
    followViewCenter.y = 55 + scrollView.contentOffset.y;
    [self.followView setCenter:CGPointMake(self.followView.center.x, followViewCenter.y)];
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
        sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height+100);
        
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
