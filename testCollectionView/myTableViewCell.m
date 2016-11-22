//
//  myTableViewCell.m
//  testCollectionView
//
//  Created by sijiechen3 on 2016/11/1.
//  Copyright © 2016年 sijiechen3. All rights reserved.
//

#import "myTableViewCell.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"

@implementation myTableViewCell

- (instancetype)initWithDataArr:(NSArray *)items {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"]) {
        if (items.count > 9) {
            UIPageControl * page = [[UIPageControl alloc] init];
            page.numberOfPages = (items.count - 1) / 9 + 1;
            [self addSubview:page];
            [page mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self);
                make.height.mas_equalTo(20);
            }];
            page.backgroundColor = [UIColor blackColor];
            
            self.collectionView = [[myCellCollectionView alloc] initWithDataArr:items];
            [self addSubview:self.collectionView];
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self);
                make.bottom.equalTo(page.mas_top);
            }];
            RAC(page, currentPage) = RACObserve(self.collectionView, curPage);
        } else {
            self.collectionView = [[myCellCollectionView alloc] initWithDataArr:items];
            
            [self addSubview:self.collectionView];
            [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }
    return self;
}

@end
