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
#import "JAHeaderView.h"
#import "JAFooterView.h"
#import "JAUILabel.h"
#import "JALoaderView.h"
#import "ParallaxFlowLayout.h"
#import "PocketSVG.h"

@interface JAArticleCollectionViewController ()
{
    
    CGSize optimalSizeForLabel;
    CGSize maximumSizeOfLabel;
    CGFloat collectionViewHeight;
}

@property (strong, nonatomic) JABlockModel *currentBlock;
@property (strong, nonatomic) JACreditModel *creditBlock;
@property (strong, nonatomic) NSMutableArray *resumesID;
@property (strong, nonatomic) JALoaderView *loaderView;

@end

@implementation JAArticleCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Collection View Initialization
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    // DATA Management
    self.manager = [JAManagerData sharedManager];
    self.plistManager = [JAPlistManager sharedInstance];
    
    JAArticleModel *article = [self.manager getCurrentArticle];
    self.blocks = [article blocks];
    self.credits = [article credits];
    // NSArray of each resume block ids
    self.resumesID = [NSMutableArray new];
    for(int i=0; i<[_blocks count]; i++) {
        self.currentBlock = _blocks[i];
        if([[self.currentBlock type] isEqualToString:@"resume"]) {
            [self.resumesID addObject:[NSNumber numberWithInt:[self.currentBlock id]]];
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
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.delegate = self;
    [self.view addGestureRecognizer:doubleTapGesture];
}

-(void)viewDidAppear:(BOOL)animated{
    if(self.headerView == nil) {
        [super viewDidAppear:animated];
        collectionViewHeight = self.collectionViewLayout.collectionViewContentSize.height - CGRectGetHeight(self.collectionView.bounds);
        [self.collectionView setContentOffset:CGPointMake(0, collectionViewHeight*self.oldPercentScroll) animated:NO];
        [self.delegate scrollRead:(self.collectionView.contentOffset.y / (self.collectionViewLayout.collectionViewContentSize.height - self.collectionView.frame.size.height)) indexArticle:self.manager.currentArticle];
        [self setupFollowView];
        [self setupHeaderView];
        [self setupFooterView];
        [self setupLoaderView];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self animateFollow];
    [self.followView fadeIn];
}


-(void)doubleTap:(UITapGestureRecognizer*)sender {
    [self.collectionView setUserInteractionEnabled:NO];
    CGFloat scrollTo;
    self.headerView.center = self.headerView.initialCenter;
    self.footerView.center = self.footerView.initialCenter;
    scrollTo = self.collectionView.contentOffset.y - collectionViewHeight*self.oldPercentScroll;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.headerView.transform = CGAffineTransformMakeTranslation(0, scrollTo);
        self.footerView.transform = CGAffineTransformMakeTranslation(0, scrollTo);
    } completion:nil];
    [self performSelector:@selector(goToChapter) withObject:nil afterDelay:1.25];
    [self.delegate scrollRead:(self.collectionView.contentOffset.y / (self.collectionViewLayout.collectionViewContentSize.height - self.collectionView.frame.size.height)) indexArticle:self.manager.currentArticle];
}

-(void)goToChapter {
	[self performSegueWithIdentifier:@"JAArticlePop" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupHeaderView {
    self.headerView = [[JAHeaderView alloc] initWithFrame:CGRectMake(0, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds))];
    [self.headerView setImage:self.snapshot];
    [self.headerView updateConstraintsIfNeeded];
    //    [self.collectionView addSubview:self.headerView];
    
    // Mask
    CGPathRef maskPath = [PocketSVG pathFromSVGFileNamed:@"top-article"];
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
    self.footerView = [[JAFooterView alloc] initWithFrame:CGRectMake(0, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds))];
    [self.footerView setImage:self.snapshot];
    [self.footerView updateConstraintsIfNeeded];
    
    //Mask
    CGPathRef maskPath = [PocketSVG pathFromSVGFileNamed:@"bottom-article"];
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
    [self.footerView animateEnterWithValue:self.collectionViewLayout.collectionViewContentSize.height];
}

- (void)setupFollowView {
    _followView = [[JAFollowView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.collectionView.bounds) -75, self.collectionView.contentOffset.y + 35, 40, 40)];
    _followView.delegate = self;
    _followView.backgroundColor = [UIColor clearColor];
    [_followView setColor:[UIColor colorWithHue:0.68 saturation:0.2 brightness:0.54 alpha:1]];
    [self.collectionView addSubview:_followView];
	[self animateFollow];
}

- (void)setupLoaderView {
    self.loaderView = [[JALoaderView alloc]initWithFrame:CGRectMake(0, 0, 160, 160)];
    self.loaderView.delegate = self;
    self.loaderView.userInteractionEnabled = NO;
    [self.collectionView addSubview:self.loaderView];
}

- (void)linkDidPressed {
    [self startLoader];
}

- (void)startLoader {
    [self.loaderView setState:UIGestureRecognizerStateBegan];
}

- (void)loadNextView {
    [self.followView fadeOut];

    [self.delegate scrollRead:(self.collectionView.contentOffset.y / (self.collectionViewLayout.collectionViewContentSize.height - self.collectionView.frame.size.height)) indexArticle:self.manager.currentArticle];
    [self performSelector:@selector(goToInfo) withObject:nil afterDelay:0.2];
}

- (void)goToInfo {
    [self performSegueWithIdentifier:@"JAInfoPush" sender:self];
}

- (IBAction)returnFromInfoView:(UIStoryboardSegue*)segue{
  
}

#pragma mark <UICollectionViewDataSource>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
    if(scrollView.contentOffset.y < -CGRectGetHeight(self.collectionView.bounds)/8) {
        [scrollView setContentOffset:CGPointMake(0, -CGRectGetHeight(self.collectionView.bounds)/8)];
    }
    else if(scrollView.contentOffset.y > collectionViewHeight + CGRectGetHeight(self.collectionView.bounds)/8) {
        [scrollView setContentOffset:CGPointMake(0, collectionViewHeight + CGRectGetHeight(self.collectionView.bounds)/8)];
    }
    
    // Header "Parallax Effect"
    CGPoint headerCenter = self.headerView.center;
    if(scrollView.contentOffset.y < 300) {
        headerCenter.y = self.headerView.initialCenter.y + scrollView.contentOffset.y*0.5;
        [self.headerView setCenter:CGPointMake(self.headerView.center.x, headerCenter.y)];
    }
    
    // Footer "Parallax Effect"
    CGPoint footerCenter = self.footerView.center;
    CGFloat maxScroll = scrollView.contentSize.height - scrollView.bounds.size.height;
    
    if(maxScroll - scrollView.contentOffset.y < 100) {
        footerCenter.y = self.footerView.initialCenter.y + (maxScroll - scrollView.contentOffset.y);
        [self.footerView setCenter:CGPointMake(self.footerView.center.x, footerCenter.y)];
    }
    
    // Follow View fixed position
    CGRect fixedFrame = self.followView.frame;
    fixedFrame.origin.y = 55 + scrollView.contentOffset.y;
    [self.followView setCenter:CGPointMake(self.followView.center.x, fixedFrame.origin.y)];
    self.followView.centerView = self.followView.center;

    // Loader View fixed position
    [self.loaderView movePosition:CGPointMake(self.collectionView.center.x, scrollView.contentOffset.y + self.collectionView.bounds.size.height/2)];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"Begin Decelerating");
}

#pragma mark - JAFollowView Delegate
- (void)followArticle:(BOOL)follow {

    [self.plistManager setValueForKey:@"follow" value:[NSNumber numberWithBool:follow] index:self.manager.currentStorie];
}

-(void)animateFollow{
    
    self.followView.validate = [[[self.plistManager getObject:@"follow"] objectAtIndex:self.manager.currentStorie] boolValue];
    NSLog(@"validate %d", self.followView.validate);
    if([[self.plistManager getObject:@"follow"] objectAtIndex:self.manager.currentStorie] == [NSNumber numberWithBool:true]){
        [self.followView animationBorder:JAAnimEntryIn];
    }
    else{
        [self.followView animationBorder:JAAnimEntryOut];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
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
            resumeCell.idx = [self.resumesID indexOfObject:[NSNumber numberWithInt:[self.currentBlock id]]];
            [resumeCell.contentView addConstraint:[NSLayoutConstraint constraintWithItem:resumeCell.resumeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:resumeCell.contentView attribute:NSLayoutAttributeRight multiplier:0.3 - (0.3-(0.3/(resumeCell.idx+1))) + CGFLOAT_MIN constant:0]];
            [resumeCell updateConstraintsIfNeeded];

            cell = resumeCell;
            
        } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            JAParagraphCollectionViewCell *paragraphCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ParagraphCell" forIndexPath:indexPath];
            paragraphCell.paragraphLabel.links = [self.currentBlock links];
            [paragraphCell.paragraphLabel initWithString:[self.currentBlock text]];
            if([self.currentBlock id] == self.blocks.count-1) {
                [paragraphCell.paragraphLabel applyMarkOfLastParagraph];
            }
            paragraphCell.paragraphLabel.delegate = self;
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
            keyNumberCell.numberLabel.links = [self.currentBlock links];
            [keyNumberCell.numberLabel initWithString:[self.currentBlock number]];
            keyNumberCell.numberLabel.delegate = self;
            [keyNumberCell.numberLabel sizeToFit];
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


#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//	return YES;
//}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // CGSizeZero not allowed
    CGSize sizeOfCell = CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
    ParallaxFlowLayout *layout = (ParallaxFlowLayout *)self.collectionViewLayout;
    CGFloat cellWidth = (CGRectGetWidth(self.collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
    
    if(indexPath.item < [self.blocks count]) {
        self.currentBlock = self.blocks[indexPath.item];
        
        if([[self.currentBlock type] isEqualToString:@"title"]) {
            
            JATitleCollectionViewCell *cell = [JATitleCollectionViewCell new];
            [cell.titleLabel  initWithString:[self.currentBlock title]];
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.titleLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height+160);
            
        } else if([[self.currentBlock type] isEqualToString:@"resume"]) {

            JAResumeCollectionViewCell *cell = [JAResumeCollectionViewCell new];
            [cell.resumeLabel  initWithString:[self.currentBlock text]];
            maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height/2);
            
        } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            JAParagraphCollectionViewCell *cell = [JAParagraphCollectionViewCell new];
            cell.paragraphLabel.links = [self.currentBlock links];
            [cell.paragraphLabel initWithString:[self.currentBlock text]];
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.paragraphLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"image"]) {
            
            UIImage *image = [UIImage imageNamed:[self.currentBlock image]];
            sizeOfCell = CGSizeMake(cellWidth, image.size.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"quote"]) {
        
            JAQuotesCollectionViewCell *cell = [JAQuotesCollectionViewCell new];
            [cell.quoteLabel initWithString:[self.currentBlock text]];
            cellWidth -= 40;
            maximumSizeOfLabel = CGSizeMake(cellWidth, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.quoteLabel sizeThatFits:maximumSizeOfLabel];
            sizeOfCell = CGSizeMake(cellWidth, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
        
            JAKeyNumberCollectionViewCell *cell = [JAKeyNumberCollectionViewCell new];
            cell.numberLabel.links = [self.currentBlock links];
            [cell.numberLabel initWithString:[self.currentBlock number]];
            cellWidth -= 40;
            [cell.numberLabel sizeToFit];
            // Factor 0.7 - Dirty solution to delete blank space 
            sizeOfCell = CGSizeMake(cellWidth, CGRectGetHeight(cell.numberLabel.bounds)*0.7);
            
        }
    } else {

        JACreditCollectionViewCell *cell = [JACreditCollectionViewCell new];
        self.creditBlock = self.credits[indexPath.item - [self.blocks count]];
        [cell.titleLabel initWithString:[self.creditBlock title]];
        [cell.namesLabel initWithString:[[self.creditBlock names] componentsJoinedByString:@"\n"]];
        cellWidth = (CGRectGetWidth(self.collectionView.bounds)/2 - layout.sectionInset.left/4 - layout.sectionInset.right);
        CGFloat cellHeight = CGRectGetHeight(cell.titleLabel.bounds) + CGRectGetHeight(cell.namesLabel.bounds);
        sizeOfCell = CGSizeMake(cellWidth, cellHeight);
        
    }
    
    return sizeOfCell;
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
