//
//  JAInfoCollectionViewController.m
//  Stories
//
//  Created by Jean-baptiste PENRATH on 21/12/2014.
//  Copyright (c) 2014 Jb & Anto. All rights reserved.
//

#import "JAInfoCollectionViewController.h"
#import "ParallaxFlowLayout.h"
#import "JAResumeCollectionViewCell.h"

@interface JAInfoCollectionViewController ()

@end

@implementation JAInfoCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // CollectionView Initialization
    
    
    // Data Management
    self.manager = [JAManagerData sharedManager];
    self.manager.currentStorie = 0;
    self.manager.currentChapter = 0;
    self.manager.currentArticle = 4;
    self.manager.currentInfo = 0;
    
    JAInfoModel *info = [self.manager getCurrentInfo];
    self.blocks = [info blocks];
    
    // Register cell classes
    [self.collectionView registerClass:[JAResumeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
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
    return [self.blocks count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JAResumeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    self.currentBlock = self.blocks[indexPath.item];
    
    [cell.resumeLabel initWithString:[self.currentBlock type]];
    
    return cell;
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
