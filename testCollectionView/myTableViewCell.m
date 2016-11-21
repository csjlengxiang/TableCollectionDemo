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
        self.hView = [[UIView alloc] init];
        [self addSubview:self.hView];
        self.hView.backgroundColor = [UIColor blackColor];
        
        [self.hView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(10);
        }];
        
        self.collectionView = [[myCellCollectionView alloc] initWithDataArr:items];
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.hView);
            make.top.equalTo(self.hView.mas_bottom);
            make.bottom.equalTo(self.mas_bottom);
            //make.height.equalTo(self).multipliedBy(xx);
        }];
        
//        UIPageControl * page = [[UIPageControl alloc] init];
//        page.numberOfPages = self.collectionView.pageCount / 8;
//        [self addSubview:page];
//        [page mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.fView);
//        }];
//        
//        page.backgroundColor = [UIColor blackColor];
//        RAC(page, currentPage) = RACObserve(self.collectionView, curPage);
    }
    return self;
}

@end
