//
//  JXNewFeatureController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/2/9.
//  Copyright © 2017年 王加祥. All rights reserved.
//  新特性界面

#import "JXNewFeatureController.h"
#import "JXNewFeatureCell.h" // 新特性表格
#import "JXTabBarController.h"

@interface JXNewFeatureController ()
/** 新特性数组 */
@property (nonatomic,strong) NSMutableArray * featureItems;
@end

@implementation JXNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = kScreen.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[JXNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setupView];
    
    
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    NSArray *array = @[@"new_feature_1",@"new_feature_2",@"new_feature_3",@"new_feature_4"];
    self.featureItems = [NSMutableArray arrayWithArray:array];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    JXLog(@"%ld",self.featureItems.count);
    return self.featureItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JXNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.featureName = self.featureItems[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.featureItems.count - 1) {
        kWinow.rootViewController = [[JXTabBarController alloc] init];
    }
}



@end
