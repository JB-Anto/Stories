//
//  ArticleCollectionViewController.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAArticleCollectionViewController.h"

@interface JAArticleCollectionViewController ()
{
    CGSize optimalSizeForLabel;
    CGSize maximumSizeOfLabel;
}
@end

@implementation JAArticleCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.articleCollectionView registerClass:[JATitleCollectionViewCell class]     forCellWithReuseIdentifier:@"TitleCell"];
    [self.articleCollectionView registerClass:[JAResumeCollectionViewCell class]    forCellWithReuseIdentifier:@"ResumeCell"];
    [self.articleCollectionView registerClass:[JAParagraphCollectionViewCell class] forCellWithReuseIdentifier:@"ParagraphCell"];
    [self.articleCollectionView registerClass:[JAImageCollectionViewCell class]     forCellWithReuseIdentifier:@"ImageCell"];
    [self.articleCollectionView registerClass:[JAQuotesCollectionViewCell class]    forCellWithReuseIdentifier:@"QuoteCell"];
    [self.articleCollectionView registerClass:[JAKeyNumberCollectionViewCell class] forCellWithReuseIdentifier:@"KeyNumberCell"];
    
    // DATA Management
    self.manager = [JAManagerData sharedManager];
    self.manager.currentStorie  = 0;
    self.manager.currentChapter = 0;
    self.manager.currentArticle = 4;
    
    _blocks = [[self.manager getCurrentArticle] blocks];
    
    // NSArray of each resume block ids
    self.resumesID = [NSMutableArray new];
    
    for(int i=0; i<[_blocks count]; i++) {
        self.currentBlock = _blocks[i];
        if([[self.currentBlock type] isEqualToString:@"resume"]) {
            [self.resumesID addObject:[self.currentBlock id]];
        }
    }
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.delegate = self;
    [self.view addGestureRecognizer:doubleTapGesture];

}

-(void)doubleTap:(UITapGestureRecognizer*)sender{
    [self performSegueWithIdentifier:@"JAArticlePop" sender:self];
//    Method to go to cover width flip
//    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _blocks.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    long row = [indexPath row];
    
    self.currentBlock = _blocks[row];
    
    if([[self.currentBlock type] isEqualToString:@"title"]) {
        
        JATitleCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];
        
        maximumSizeOfLabel = CGSizeMake(256, CGFLOAT_MAX);
        
        // Title Label Settings
        [cell.titleLabel setText:[self.currentBlock title]];
        [cell.titleLabel setLineHeightWithNumber:0.85];
        //CGRect titleLabelRect = [cell.titleLabel calculateRectInBoundingRectWithSize:maximumLabelSize];
        optimalSizeForLabel = [cell.titleLabel sizeThatFits:maximumSizeOfLabel];
        [cell.titleLabel setFrame:CGRectMake(20, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
        
        // Location Label Settings
        [cell.locationLabel setText:[self.currentBlock location]];
        [cell.locationLabel setLineSpacingWithNumber:1.25];
        [cell.locationLabel sizeToFit];
        [cell.locationLabel setFrame:CGRectMake(cell.center.x - cell.bounds.size.width/2, cell.center.y - cell.locationLabel.frame.size.height/2, cell.bounds.size.width, cell.locationLabel.frame.size.height)];
        
        // Date Label Settings
        // Date out format
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"MMM\u00A0dd"];
        
        // Date in format
        NSDateFormatter *dateFormaterFromString = [[NSDateFormatter alloc]init];
        [dateFormaterFromString setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        
        NSDate *date = [dateFormaterFromString dateFromString:[self.currentBlock createdAt]];
        NSString *finalDate = [dateFormater stringFromDate:date];
        
        [cell.dateLabel setText:finalDate];
        [cell.dateLabel setLineSpacingWithNumber:1.25];
        
        [cell.dateLabel sizeToFit];
        [cell.dateLabel setFrame:CGRectMake(cell.center.x - cell.bounds.size.width/2 , cell.center.y + cell.dateLabel.frame.size.height/2, cell.bounds.size.width, cell.dateLabel.frame.size.height)];
        
        return cell;
        
    }
    else if([[self.currentBlock type] isEqualToString:@"resume"]) {
        
        JAResumeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ResumeCell" forIndexPath:indexPath];
        
        [cell.resumeLabel setText:[self.currentBlock text]];
        
        // Resume Label Settings
        maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];

        NSInteger index = [self.resumesID indexOfObject:[self.currentBlock id]];
        CGFloat positionOfLabel =  (CGRectGetWidth(self.view.bounds)*0.5-optimalSizeForLabel.width/2) - (index * (CGRectGetWidth(self.view.bounds)*0.5-optimalSizeForLabel.width/2)/([self.resumesID count]-1)/1.5) + 20;
        [cell.resumeLabel setFrame:CGRectMake(positionOfLabel, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
        
        return cell;
        
    }
    else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
        
        JAParagraphCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ParagraphCell" forIndexPath:indexPath];
        
        [cell.paragraphLabel setText:[self.currentBlock text]];
        [cell.paragraphLabel setLineHeightWithNumber:1.5];
        maximumSizeOfLabel = CGSizeMake(CGRectGetWidth(self.view.bounds)-40, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.paragraphLabel sizeThatFits:maximumSizeOfLabel];
        [cell.paragraphLabel setFrame:CGRectMake(20, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
        
        return cell;
        
    }
    else if([[self.currentBlock type] isEqualToString:@"quote"]) {
        
        JAQuotesCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"QuoteCell" forIndexPath:indexPath];
        
        [cell.quoteLabel setText:[self.currentBlock text]];
        [cell.quoteLabel setLineHeightWithNumber:1.23];
        
        [cell.authorLabel setText:[self.currentBlock author]];
        [cell.authorLabel setLineHeightWithNumber:1.25];
        
        maximumSizeOfLabel = CGSizeMake(225, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.quoteLabel sizeThatFits:maximumSizeOfLabel];
        
        [cell.quoteLabel setFrame:CGRectMake(0, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
        [cell.authorLabel sizeToFit];
        [cell.authorLabel setTextAlignment:NSTextAlignmentRight];
        [cell.authorLabel setFrame:CGRectMake(CGRectGetWidth(cell.bounds)-CGRectGetWidth(cell.authorLabel.bounds)-20, CGRectGetHeight(cell.quoteLabel.bounds)-CGRectGetHeight(cell.authorLabel.bounds)/1.15, CGRectGetWidth(cell.authorLabel.bounds), CGRectGetHeight(cell.authorLabel.bounds))];
        
        return cell;
        
    }
    else if([[self.currentBlock type] isEqualToString:@"image"]) {

        JAImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
        
        [cell.imageView setImage:[UIImage imageNamed:[self.currentBlock image]]];
        [cell.imageView setFrame:CGRectMake(0, 0, cell.imageView.image.size.width, cell.imageView.image.size.height)];
        [cell.legendLabel setText:[self.currentBlock text]];
        [cell.legendLabel setLineHeightWithNumber:1.6];
        
        maximumSizeOfLabel = CGSizeMake(185, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.legendLabel sizeThatFits:maximumSizeOfLabel];
        [cell.legendLabel setFrame:CGRectMake(cell.imageView.image.size.width*0.65, CGRectGetHeight(cell.bounds)/2 - optimalSizeForLabel.height/2, optimalSizeForLabel.width, optimalSizeForLabel.height)];

        return cell;
        
    }
    else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
        
        JAKeyNumberCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"KeyNumberCell" forIndexPath:indexPath];
        
        [cell.numberLabel setText:[self.currentBlock number]];
        [cell.numberLabel sizeToFit];
        
        [cell.descriptionLabel setText:[self.currentBlock text]];
        [cell.descriptionLabel setLineHeightWithNumber:1.29];
        
        maximumSizeOfLabel = CGSizeMake(195, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.descriptionLabel sizeThatFits:maximumSizeOfLabel];
        
        [cell.descriptionLabel setFrame:CGRectMake(CGRectGetWidth(cell.numberLabel.bounds)/2, CGRectGetHeight(cell.numberLabel.bounds)/2 - optimalSizeForLabel.height/4, optimalSizeForLabel.width, optimalSizeForLabel.height)];
        
        return cell;
        
    }
    else {
        return nil;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.currentBlock = _blocks[[indexPath row]];
    
    if([[self.currentBlock type] isEqualToString:@"title"]) {
        
        // Calculate height of title cell in function of title label height
        JATitleCollectionViewCell *cell = [JATitleCollectionViewCell new];
        
        [cell.titleLabel  setText:[self.currentBlock title]];
        [cell.titleLabel setLineHeightWithNumber:0.85];
        maximumSizeOfLabel = CGSizeMake(256, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.titleLabel sizeThatFits:maximumSizeOfLabel];

        return CGSizeMake(self.view.bounds.size.width, optimalSizeForLabel.height);
        
    } else if([[self.currentBlock type] isEqualToString:@"resume"]) {
        
        // Calculate height of resume cell in function of resume label height
        JAResumeCollectionViewCell *cell = [JAResumeCollectionViewCell new];
        [cell.resumeLabel  setText:[self.currentBlock text]];
        
        maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];
        
        return CGSizeMake(CGRectGetWidth(self.view.bounds), optimalSizeForLabel.height-25);
        
    } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
    
        // Calculate height of paragraph cell in function of parapragh label height
        JAParagraphCollectionViewCell *cell = [JAParagraphCollectionViewCell new];
        [cell.paragraphLabel  setText:[self.currentBlock text]];
        [cell.paragraphLabel setLineHeightWithNumber:1.5];
        
        maximumSizeOfLabel = CGSizeMake(self.view.bounds.size.width-40, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.paragraphLabel sizeThatFits:maximumSizeOfLabel];
        
        return CGSizeMake(CGRectGetWidth(self.view.bounds), optimalSizeForLabel.height);
        
    } else if([[self.currentBlock type] isEqualToString:@"image"]) {
        
        // Calculate height of image cell in function of image view height
        UIImage *image = [UIImage imageNamed:[self.currentBlock image]];
        
        return CGSizeMake(CGRectGetWidth(self.view.bounds), image.size.height);
        
    } else if([[self.currentBlock type] isEqualToString:@"quote"]) {
        
        // Calculate height of quote cell in function of quote & author label height
        JAQuotesCollectionViewCell *cell = [JAQuotesCollectionViewCell new];
        [cell.quoteLabel setText:[self.currentBlock text]];
        [cell.quoteLabel setLineHeightWithNumber:1.23];
        
        [cell.authorLabel setText:[self.currentBlock author]];
        [cell.authorLabel sizeToFit];
        
        maximumSizeOfLabel = CGSizeMake(225, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.quoteLabel sizeThatFits:maximumSizeOfLabel];
        
        
        return CGSizeMake(CGRectGetWidth(self.view.bounds)-80, optimalSizeForLabel.height + (CGRectGetHeight(cell.authorLabel.bounds)*0.15));
        
    } else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
        
        // Calculate height of quote cell in function of quote & author label height
        JAKeyNumberCollectionViewCell *cell = [JAKeyNumberCollectionViewCell new];
        [cell.numberLabel setText:[self.currentBlock number]];
        [cell.numberLabel sizeToFit];
        
        [cell.descriptionLabel setText:[self.currentBlock text]];
        [cell.descriptionLabel setLineHeightWithNumber:1.29];
        
        maximumSizeOfLabel = CGSizeMake(195, CGFLOAT_MAX);
        optimalSizeForLabel = [cell.descriptionLabel sizeThatFits:maximumSizeOfLabel];
        
        
        return CGSizeMake(CGRectGetWidth(self.view.bounds)-80, (optimalSizeForLabel.height/4) + CGRectGetHeight(cell.numberLabel.bounds));
        
    }
    else {
        return CGSizeZero;
    }
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
