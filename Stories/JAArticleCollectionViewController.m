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
    int maxHeight;
    int heightOfCreditCell;
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
    [self.articleCollectionView registerClass:[UICollectionViewCell class]   forCellWithReuseIdentifier:@"CreditsCell"];
    
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
    
    heightOfCreditCell = 0;
    
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
    
    NSInteger numberOfSection = self.blocks.count;
    
    if(self.credits) {
        numberOfSection++;
    }
    
    return numberOfSection;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if([indexPath row] < self.blocks.count) {
        self.currentBlock = self.blocks[[indexPath row]];
        
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
            
            // Set size hoped
            maximumSizeOfLabel = CGSizeMake(256, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.titleLabel sizeThatFits:maximumSizeOfLabel];
            
            // Set frames
            [cell.titleLabel setFrame:CGRectMake(20, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
            [cell.locationLabel setFrame:CGRectMake(cell.center.x - CGRectGetWidth(cell.locationLabel.bounds)/2, cell.center.y - CGRectGetHeight(cell.locationLabel.bounds)/2, CGRectGetWidth(cell.locationLabel.bounds), CGRectGetHeight(cell.locationLabel.bounds))];
            [cell.dateLabel setFrame:CGRectMake(cell.center.x - cell.dateLabel.bounds.size.width/2 , cell.center.y + cell.dateLabel.frame.size.height/2, CGRectGetWidth(cell.dateLabel.bounds), CGRectGetHeight(cell.dateLabel.bounds))];
            
            return cell;
            
        }
        else if([[self.currentBlock type] isEqualToString:@"resume"]) {
            
            JAResumeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ResumeCell" forIndexPath:indexPath];
            
            // Set Content
            [cell.resumeLabel initWithString:[self.currentBlock text]];
            
            // Set size hoped
            maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];
            
            // Set frames
            NSInteger index = [self.resumesID indexOfObject:[self.currentBlock id]];
            CGFloat positionOfLabel =  (CGRectGetWidth(self.view.bounds)*0.5-optimalSizeForLabel.width/2) - (index * (CGRectGetWidth(self.view.bounds)*0.5-optimalSizeForLabel.width/2)/([self.resumesID count]-1)/1.5) + 20;
            [cell.resumeLabel setFrame:CGRectMake(positionOfLabel, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
            
            return cell;
            
        }
        else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            JAParagraphCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ParagraphCell" forIndexPath:indexPath];
            
            // Set Content
            cell.paragraphLabel.links = [self.currentBlock links];
            [cell.paragraphLabel initWithString:[self.currentBlock text]];
            
            // Set size hoped
            maximumSizeOfLabel = CGSizeMake(CGRectGetWidth(self.view.bounds)-40, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.paragraphLabel sizeThatFits:maximumSizeOfLabel];
            
            // Set frames
            [cell.paragraphLabel setFrame:CGRectMake(20, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
            
            return cell;
            
        }
        else if([[self.currentBlock type] isEqualToString:@"quote"]) {
            
            JAQuotesCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"QuoteCell" forIndexPath:indexPath];
            
            //Set Content
            [cell.quoteLabel initWithString:[self.currentBlock text]];
            [cell.authorLabel initWithString:[self.currentBlock author]];
            
            //Set size hoped
            maximumSizeOfLabel = CGSizeMake(225, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.quoteLabel sizeThatFits:maximumSizeOfLabel];
            
            //Set frames
            [cell.quoteLabel setFrame:CGRectMake(0, 0, optimalSizeForLabel.width, optimalSizeForLabel.height)];
            [cell.authorLabel setTextAlignment:NSTextAlignmentRight];
            [cell.authorLabel setFrame:CGRectMake(CGRectGetWidth(cell.bounds)-CGRectGetWidth(cell.authorLabel.bounds)-20, CGRectGetHeight(cell.quoteLabel.bounds)-CGRectGetHeight(cell.authorLabel.bounds)/1.15, CGRectGetWidth(cell.authorLabel.bounds), CGRectGetHeight(cell.authorLabel.bounds))];
            
            return cell;
            
        }
        else if([[self.currentBlock type] isEqualToString:@"image"]) {
            
            JAImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
            
            //Set Content
            [cell.legendLabel initWithString:[self.currentBlock text]];
            [cell.imageView setImage:[UIImage imageNamed:[self.currentBlock image]]];
            
            //Set size hoped
            maximumSizeOfLabel = CGSizeMake(185, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.legendLabel sizeThatFits:maximumSizeOfLabel];
            
            //Set frames
            [cell.imageView setFrame:CGRectMake(0, 0, cell.imageView.image.size.width, cell.imageView.image.size.height)];
            [cell.legendLabel setFrame:CGRectMake(cell.imageView.image.size.width*0.65, CGRectGetHeight(cell.bounds)/2 - optimalSizeForLabel.height/2, optimalSizeForLabel.width, optimalSizeForLabel.height)];
            
            return cell;
            
        }
        else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
            
            JAKeyNumberCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"KeyNumberCell" forIndexPath:indexPath];
            
            //Set content
            [cell.numberLabel initWithString:[self.currentBlock number]];
            [cell.descriptionLabel initWithString:[self.currentBlock text]];
            
            //Set size hoped
            maximumSizeOfLabel = CGSizeMake(195, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.descriptionLabel sizeThatFits:maximumSizeOfLabel];
            
            //Set frames
            [cell.descriptionLabel setFrame:CGRectMake((CGRectGetWidth(cell.numberLabel.bounds)*0.9)/2, cell.numberLabel.bounds.origin.y + (CGRectGetHeight(cell.numberLabel.bounds)*0.728)/2-optimalSizeForLabel.height*0.154, optimalSizeForLabel.width, optimalSizeForLabel.height)];
            
            return cell;
            
        }
        else {
            return nil;
        }
    } else {
        
        UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CreditsCell" forIndexPath:indexPath];

        maximumSizeOfLabel = CGSizeMake(CGRectGetWidth(self.view.bounds), CGFLOAT_MAX);
        heightOfCreditCell = 0;
        maxHeight = 0;
        
        [self.credits enumerateObjectsUsingBlock:^(JACreditModel *credit, NSUInteger idx, BOOL *stop)
        {
        
            if(idx % 2 == 0) {
                heightOfCreditCell += idx > 0 ? maxHeight+15 : maxHeight;
                maxHeight = 0;
            }
            
            JACreditsView *creditView = [JACreditsView new];
            
            [creditView.titleLabel initWithString:credit.title];
            [creditView.namesLabel initWithString:[credit.names componentsJoinedByString:@"\n"]];
            
            optimalSizeForLabel = [creditView.namesLabel sizeThatFits:maximumSizeOfLabel];
            
            [creditView.namesLabel setFrameForThisBounds:CGRectMake(0, CGRectGetHeight(creditView.titleLabel.bounds), optimalSizeForLabel.width, optimalSizeForLabel.height)];
            
            int x = idx%2 == 0 ? 0 : (CGRectGetWidth(self.view.bounds)-40)/2;
            int height = CGRectGetHeight(creditView.titleLabel.bounds) + CGRectGetHeight(creditView.namesLabel.bounds);
            
            if(height > maxHeight) {
                maxHeight = height;
            }
            
            [creditView setFrame:CGRectMake(x, heightOfCreditCell, (CGRectGetWidth(self.view.bounds)-40)/2, height)];
            
            [cell addSubview:creditView];
            
        }];
        
        NSLog(@"Init: %d", heightOfCreditCell);
        
        return cell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([indexPath row] < [self.blocks count]) {
        self.currentBlock = self.blocks[[indexPath row]];
        
        if([[self.currentBlock type] isEqualToString:@"title"]) {
            
            // Calculate height of title cell in function of title label height
            JATitleCollectionViewCell *cell = [JATitleCollectionViewCell new];
            
            [cell.titleLabel  initWithString:[self.currentBlock title]];
            
            maximumSizeOfLabel = CGSizeMake(256, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.titleLabel sizeThatFits:maximumSizeOfLabel];
            
            return CGSizeMake(self.view.bounds.size.width, optimalSizeForLabel.height);
            
        } else if([[self.currentBlock type] isEqualToString:@"resume"]) {
            
            // Calculate height of resume cell in function of resume label height
            JAResumeCollectionViewCell *cell = [JAResumeCollectionViewCell new];
            
            [cell.resumeLabel  initWithString:[self.currentBlock text]];
            
            maximumSizeOfLabel = CGSizeMake(160, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.resumeLabel sizeThatFits:maximumSizeOfLabel];
            
            return CGSizeMake(CGRectGetWidth(self.view.bounds), optimalSizeForLabel.height-25);
            
        } else if([[self.currentBlock type] isEqualToString:@"paragraph"]) {
            
            // Calculate height of paragraph cell in function of parapragh label height
            JAParagraphCollectionViewCell *cell = [JAParagraphCollectionViewCell new];
            
            cell.paragraphLabel.links = [self.currentBlock links];
            [cell.paragraphLabel  initWithString:[self.currentBlock text]];
            
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
            
            [cell.quoteLabel initWithString:[self.currentBlock text]];
            [cell.authorLabel initWithString:[self.currentBlock author]];
            
            maximumSizeOfLabel = CGSizeMake(225, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.quoteLabel sizeThatFits:maximumSizeOfLabel];
            
            return CGSizeMake(CGRectGetWidth(self.view.bounds)-80, optimalSizeForLabel.height + (CGRectGetHeight(cell.authorLabel.bounds)*0.15));
            
        } else if([[self.currentBlock type] isEqualToString:@"keyNumber"]) {
            
            // Calculate height of quote cell in function of quote & author label height
            JAKeyNumberCollectionViewCell *cell = [JAKeyNumberCollectionViewCell new];
            
            [cell.numberLabel initWithString:[self.currentBlock number]];
            [cell.descriptionLabel initWithString:[self.currentBlock text]];
            
            maximumSizeOfLabel = CGSizeMake(195, CGFLOAT_MAX);
            optimalSizeForLabel = [cell.descriptionLabel sizeThatFits:maximumSizeOfLabel];
            
            return CGSizeMake(CGRectGetWidth(self.view.bounds)-80, (optimalSizeForLabel.height/4) + CGRectGetHeight(cell.numberLabel.bounds));
            
        }
        else {
            
            // CGSizeZero not allowed...
            return CGSizeMake(1,1);
            
        }
    } else {
        
        maximumSizeOfLabel = CGSizeMake(CGRectGetWidth(self.view.bounds), CGFLOAT_MAX);
        heightOfCreditCell = 0;
        
        [self.credits enumerateObjectsUsingBlock:^(JACreditModel *credit, NSUInteger idx, BOOL *stop)
         {
             
             JACreditsView *creditView = [JACreditsView new];
             
             [creditView.titleLabel initWithString:credit.title];
             [creditView.namesLabel initWithString:[credit.names componentsJoinedByString:@"\n"]];
             
             optimalSizeForLabel = [creditView.namesLabel sizeThatFits:maximumSizeOfLabel];
             
             [creditView.namesLabel setFrameForThisBounds:CGRectMake(0, CGRectGetHeight(creditView.titleLabel.bounds), optimalSizeForLabel.width, optimalSizeForLabel.height)];
             
             int x = idx%2 == 0 ? 0 : CGRectGetWidth(self.view.bounds)/2;
             int height = CGRectGetHeight(creditView.titleLabel.bounds) + CGRectGetHeight(creditView.namesLabel.bounds);
             
             if(height > maxHeight) {
                 maxHeight = height;
             }
             
             [creditView setFrame:CGRectMake(x, 0, (CGRectGetWidth(self.view.bounds)-40)/2, height)];
             
             if(idx % 2 == 0) {
                 heightOfCreditCell += idx > 0 ? maxHeight+15 : maxHeight;
                 maxHeight = 0;
             }
            
             
         }];
        
        return CGSizeMake(CGRectGetWidth(self.view.bounds)-40, heightOfCreditCell);
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
