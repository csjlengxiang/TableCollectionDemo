//
//  myTableViewCell.h
//  testCollectionView
//
//  Created by sijiechen3 on 2016/11/1.
//  Copyright © 2016年 sijiechen3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCellCollectionView.h"

@interface myTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView * hView;

@property (strong, nonatomic) myCellCollectionView * collectionView;

- (instancetype)initWithDataArr:(NSArray *)items;

@end
