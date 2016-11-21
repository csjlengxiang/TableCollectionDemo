//
//  myCellCollectionView.h
//  testCollectionView
//
//  Created by sijiechen3 on 2016/11/1.
//  Copyright © 2016年 sijiechen3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCellCollectionView : UICollectionView

@property(nonatomic, assign) NSUInteger pageCount;
@property(nonatomic, assign) NSUInteger curPage;
@property(nonatomic, assign) NSUInteger rowCount;

- (instancetype)initWithDataArr:(NSArray *)items;

@end

