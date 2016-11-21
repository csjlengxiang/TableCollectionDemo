//
//  myCellCollectionView.m
//  testCollectionView
//
//  Created by sijiechen3 on 2016/11/1.
//  Copyright © 2016年 sijiechen3. All rights reserved.
//

#import "myCellCollectionView.h"
#import "LWLCollectionViewHorizontalLayout.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREEN_SCALE ([ UIScreen mainScreen ].bounds.size.width/320)
//随机色
#define LWLRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface CollectionCell : UICollectionViewCell

@property(nonatomic, weak) UILabel *titleLabel;

@end

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel = titleLabel;
        [self.contentView addSubview:self.titleLabel];
        self.backgroundColor = LWLRandomColor;
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////
@interface CollectionCellWhite : CollectionCell

@end


@implementation CollectionCellWhite

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

@interface myCellCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) NSArray *items;

@end

@implementation myCellCollectionView

- (instancetype)initWithDataArr:(NSArray *)items {
    
    NSUInteger rowCount = 3;
    NSUInteger itemCountPerRow = 3;
    _items = items;
    NSLog(@"%f", _items.count / 9.0);
    _pageCount = _items.count;
    if (_items.count <= 3) {
        rowCount = 1;
        _pageCount = 3;
    } else if (_items.count <= 6) {
        rowCount = 2;
        _pageCount = 6;
    } else {
        if (_items.count <= 9) {
            _pageCount = 9;
        } else {
            while (_pageCount % 9 != 0) {
                ++_pageCount;
            }
        }
        rowCount = 3;
    }
    
    self.rowCount = rowCount;

    LWLCollectionViewHorizontalLayout *layout =[[LWLCollectionViewHorizontalLayout alloc] init];
    layout.rowCount = rowCount;
    layout.itemCountPerRow = itemCountPerRow;
    layout.itemSize = CGSizeMake(SCREENW/itemCountPerRow, SCREENW/itemCountPerRow);
    layout.minimumInteritemSpacing = 0*SCREEN_SCALE;
    layout.minimumLineSpacing = 0*SCREEN_SCALE;
    layout.headerReferenceSize = CGSizeMake(0*SCREEN_SCALE, 0*SCREEN_SCALE);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[CollectionCellWhite class]
           forCellWithReuseIdentifier:@"CellWhite"];
        
        [self registerClass:[CollectionCell class]
           forCellWithReuseIdentifier:@"Cell"];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return _pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"Cell";
    
    CollectionCell *cell = nil;
    if (indexPath.item >= _items.count) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellWhite"
                                                         forIndexPath:indexPath];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifierCell
                                                         forIndexPath:indexPath];
        cell.titleLabel.text =
        [NSString stringWithFormat:@"第%ld个礼物", (long)indexPath.row];
    }
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.curPage = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    NSLog(@"-- %ld", self.curPage);
}
@end
