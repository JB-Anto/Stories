//
//  ArticleCollectionViewController.m
//  Stories
//
//  Created by PENRATH Jean-baptiste on 14/11/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAArticleCollectionViewController.h"

@interface JAArticleCollectionViewController ()

@end

@implementation JAArticleCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // FAKE DATA
    
    NSDictionary *title = [NSDictionary dictionaryWithObjectsAndKeys:
                                        @"title", @"type",
                                        @"Ukraine president accepts embatted defence minister's resignation", @"title",
                                        @"Kiev", @"location",
                                        @"Oct, 12", @"date", nil];
    
    NSDictionary *resume1 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"resume", @"type",
                             @"Defence minister criticised over August rout of troops", @"resume", nil];
    
    NSDictionary *resume2 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"resume", @"type",
                             @"President hopes tot nominate successor on Monday", @"resume", nil];
    
    NSDictionary *resume3 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"resume", @"type",
                             @"Fragile ceasefire in eastern Ukraine broadly holding", @"resume", nil];

    NSDictionary *paragraph1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"paragraph", @"type",
                                @"Ukrainian president Petro Poroshenko accepted on Sunday the resignation of his defence minister who has been under fire over a rout of government forces in the east which let to Kiev calling a ceasefire with pro-Russian separatists.", @"paragraph", nil];

    NSDictionary *image = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"image", @"type",
                           @"imageFake", @"image",
                           @"US Attorney General Eric Holder speaks at the opening of the Ukraine Forum of Asset Recovery at Lancaster House in Central London, April 29, 2014.", @"description", nil];

    NSDictionary *paragraph2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"paragraph", @"type",
                                @"Poroshenko’s website said the president had accepted the offer of resignation from Valery Heletey, 47, whom he appointed only in July. It said Poroshenko hoped to present a new ministerial candidate to parliament on Monday.", @"paragraph", nil];
    
    NSDictionary *quote = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"quote", @"type",
                           @"“I don’t have illusion. These will be difficult talks. But I am.”", @"quote",
                           @"Petro Poroshenko", @"author", nil];

    NSDictionary *paragraph3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"paragraph", @"type",
                                @"Heletey who formerly led a presidential bodyguard unit, had drawn criticism since the crushing defeat of Ukrainian forces at Ilovaisk, east of the main rebel held eastern city of Donetsk, in late August.", @"paragraph", nil];
    
    NSDictionary *paragraph4 = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"paragraph", @"type",
                                @"Ukrainian military sources say a large number of Russian troops were also killed - a charge not acknowledged by Moscow, which denies any part in the Ukraine Conflict despite what Kiev and Western governements say is incontrovertible proof.", @"paragraph", nil];
    
    NSDictionary *keyNumber = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"number", @"type",
                               @"102", @"number",
                               @"Ukrainian troops were killed", @"description", nil];
    
    NSDictionary *paragraph5 = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"paragraph", @"type",
                                @"Analysts say the Aug. 24 attack led Poroshenko reluctantly to accept that Kiev could not beat the separatists militarily as long as they were sypported by direct involvement of Russian troops and equipment", @"paragraph", nil];
    
    
    //_blocks = [@[title, resume1, resume2, resume3, paragraph1, image, paragraph2, quote, paragraph3, paragraph4, keyNumber, paragraph5] mutableCopy];
    _blocks = [@[title, resume1, resume2, resume3, paragraph1, image, paragraph2, quote, paragraph3, paragraph4, keyNumber, paragraph5] mutableCopy];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _blocks.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    long row = [indexPath row];
    
    NSLog(@"%@", _blocks[row]);
    
    NSDictionary *currentBlock = [NSDictionary dictionaryWithDictionary:_blocks[row]];
    
    if([[currentBlock objectForKey:@"type"] isEqualToString:@"title"]) {
        JATitleCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"TitleCell" forIndexPath:indexPath];
        
        [cell.titleLabel setText:[currentBlock objectForKey:@"title"]];
        [cell.locationLabel setText:[currentBlock objectForKey:@"location"]];
        [cell.dateLabel setText:[currentBlock objectForKey:@"date"]];
        
        return cell;
        
    }
    else if([[currentBlock objectForKey:@"type"] isEqualToString:@"resume"]) {
        JAResumeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ResumeCell" forIndexPath:indexPath];
        
        [cell.resumeLabel setText:[currentBlock objectForKey:@"resume"]];
        
        return cell;
        
    }
    else if([[currentBlock objectForKey:@"type"] isEqualToString:@"paragraph"]) {
        JAParagraphCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ParagraphCell" forIndexPath:indexPath];
        
        [cell.paragraphLabel setText:[currentBlock objectForKey:@"paragraph"]];
        
        return cell;
    }
    else if([[currentBlock objectForKey:@"type"] isEqualToString:@"quote"]) {
        JAQuotesCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"QuotesCell" forIndexPath:indexPath];
        
        [cell.quotesLabel setText:[currentBlock objectForKey:@"quote"]];
        [cell.authorLabel setText:[currentBlock objectForKey:@"author"]];
        
        return cell;
    }
    else if([[currentBlock objectForKey:@"type"] isEqualToString:@"image"]) {
        JAImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:[currentBlock objectForKey:@"image"]];
        [cell.legendLabel setText:[currentBlock objectForKey:@"author"]];
        
        return cell;
    }
    else if([[currentBlock objectForKey:@"type"] isEqualToString:@"number"]) {
        JAKeyNumberCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"KeyNumberCell" forIndexPath:indexPath];
        
        [cell.numberLabel setText:[currentBlock objectForKey:@"number"]];
        [cell.descriptionLabel setText:[currentBlock objectForKey:@"description"]];
        return cell;
    }
    else {
        return nil;
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

@end
