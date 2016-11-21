//
//  ViewController.m
//  testCollectionView
//
//  Created by sijiechen3 on 2016/11/1.
//  Copyright © 2016年 sijiechen3. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "myTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的徽章";
    
    myTableView * tableView = [[myTableView alloc] init];
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        //make.left.right.bottom.equalTo(self.view);
        //make.top.equalTo(self.view);
        //make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", self.view);
}

@end
