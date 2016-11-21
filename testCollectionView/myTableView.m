//
//  myTableView.m
//  testCollectionView
//
//  Created by sijiechen3 on 2016/11/1.
//  Copyright © 2016年 sijiechen3. All rights reserved.
//

#import "myTableView.h"
#import "myTableViewCell.h"

@interface myTableView () <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) myTableViewCell * cell;

@property (strong, nonatomic) NSArray * tableSourceData;
@property (strong, nonatomic) NSArray * cellArr;

@end

@implementation myTableView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped]) {
        self.delegate = self;
        self.dataSource = self;
        
        NSMutableArray * tableSourceData = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            NSMutableArray * collectionSourceDate = [NSMutableArray new];
            for (int num = 0; num < i * 3 + 2; num++) {
                [collectionSourceDate addObject:@(num)];
            }
            [tableSourceData addObject:collectionSourceDate];
        }
        self.tableSourceData = tableSourceData;
        
        NSMutableArray * cellArr = [NSMutableArray new];
        for (int i = 0; i < self.tableSourceData.count; i++) {
            myTableViewCell * cell = [[myTableViewCell alloc] initWithDataArr:self.tableSourceData[i]];
            [cellArr addObject:cell];
        }
        self.cellArr = cellArr;
    }
    return self;
}

#pragma mark - UITableViewDelegate

- (CGFloat)heightForCollectionNum:(int)number {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = width / 3.0;
    NSAssert(number > 0, @"number must bigger than zero");
    int bs = (number - 1) / 3 + 1;
    bs = MIN(3, bs);
    return height * bs;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int number = (int)[[self.tableSourceData objectAtIndex:indexPath.row] count];
    CGFloat height = [self heightForCollectionNum:number] + 10;
    NSLog(@"---- height %f", height);
    return height;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableSourceData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellArr objectAtIndex:indexPath.row];
}

@end
