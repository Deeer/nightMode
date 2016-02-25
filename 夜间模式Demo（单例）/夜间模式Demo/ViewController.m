//
//  ViewController.m
//  夜间模式Demo
//
//  Created by kylehe on 16/2/25.
//  Copyright © 2016年 Kyle He. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UISwitch  *nightSwitch;

@property(nonatomic, strong) UITableView  *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.nightSwitch];
    self.nightSwitch.frame = CGRectMake(50, 60, 20, 20);
    [self.nightSwitch addTarget:self action:@selector(changeNightMode) forControlEvents:UIControlEventValueChanged];
    self.tableView.frame = CGRectMake(0, self.view.frame.size.width, self.view.frame.size.height, self.view.frame.size.width);
    [self.view addSubview:self.tableView];
}

- (void)changeNightMode
{
    if (self.nightSwitch.on)
    {
        self.view.backgroundColor = [UIColor grayColor];
        self.tableView.backgroundColor = [UIColor lightGrayColor];
    }else
    {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    [self.tableView reloadData];
}

#pragma mark - uitableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.nightSwitch.on)
    {
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.textColor  = [UIColor whiteColor];
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = @"Yoooo";
    return cell;
}


#pragma mark － setterAndGetter
- (UISwitch *)nightSwitch
{
    if (!_nightSwitch)
    {
        _nightSwitch = [[UISwitch alloc] init];
    }
    return _nightSwitch;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
