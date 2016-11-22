//
//  myTableView.m
//  testCollectionView
//
//  Created by sijiechen3 on 2016/11/1.
//  Copyright © 2016年 sijiechen3. All rights reserved.
//

#import "myTableView.h"
#import "myTableViewCell.h"
#define LWLRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface myTableView () <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) myTableViewCell * cell;

@property (strong, nonatomic) NSArray * tableSourceData;
@property (strong, nonatomic) NSArray * cellArr;
@property (strong, nonatomic) NSMutableDictionary * hiddenSet;

@end

@implementation myTableView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero style:UITableViewStylePlain]) {
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
        
        self.hiddenSet = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < self.tableSourceData.count; i++) {
            [self.hiddenSet setObject:@(i) forKey:[NSString stringWithFormat:@"%d", i]];
        }
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
    int number = (int)[[self.tableSourceData objectAtIndex:indexPath.section] count];
    CGFloat height = [self heightForCollectionNum:number];
    NSLog(@"---- height %f", height);
    return height;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] init];
    view.tag = section + 1000;
    view.backgroundColor = LWLRandomColor;
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    lb.text = [NSString stringWithFormat:@"第 %ld 个section", (long)section];
    [view addSubview:lb];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [view addGestureRecognizer:tap];
    return view;
}

- (void)tap:(UITapGestureRecognizer *)sender {
    long sec = sender.view.tag - 1000;
    NSString * key = [NSString stringWithFormat:@"%ld", sec];
    if ([self.hiddenSet valueForKey:key]) {
        [self.hiddenSet removeObjectForKey:key];
    } else {
        [self.hiddenSet setObject:@(sec) forKey:key];
    }
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:sec];
    [self reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableSourceData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sec {
    if ([self.hiddenSet valueForKey:[NSString stringWithFormat:@"%ld", sec]]) {
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellArr objectAtIndex:indexPath.section];
}

@end
