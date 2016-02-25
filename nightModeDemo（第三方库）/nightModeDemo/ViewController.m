//
//  ViewController.m
//  nightModeDemo
//
//  Created by kylehe on 16/2/25.
//  Copyright © 2016年 Kyle He. All rights reserved.
//

#import "ViewController.h"

#import "DKNightVersion.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UISwitch  *modeSwitch;

@property(nonatomic, strong) UITableView  *tabblveView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tabblveView];
    self.tabblveView.frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
    [self.view addSubview:self.modeSwitch];
    self.modeSwitch.frame = CGRectMake(30, 30, 30, 30);
    self.tabblveView.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x343434);
    self.view.dk_backgroundColorPicker = DKColorWithRGB(0xaaaaaa, 0x343434);
}

#pragma mark - privateMathod
- (void)changeMode
{
    if (self.modeSwitch.on)
    {
      [DKNightVersionManager nightFalling];
    }else
    {
        [DKNightVersionManager dawnComing];
    }
    [self.tabblveView reloadData];
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
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor lightGrayColor]);
    cell.dk_tintColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    cell.textLabel.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor whiteColor]);
    cell.textLabel.text = @"uoooo";
    return cell;
}

#pragma mark - setterAndGetter
- (UISwitch *)modeSwitch
{
    if (!_modeSwitch)
    {
        _modeSwitch = [[UISwitch alloc] init];
        [_modeSwitch addTarget:self action:@selector(changeMode) forControlEvents:UIControlEventValueChanged];
    }
    return _modeSwitch;
}

- (UITableView *)tabblveView
{
    if (!_tabblveView)
    {
        _tabblveView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tabblveView.delegate = self;
        _tabblveView.dataSource = self;
    }
    return _tabblveView;
}

@end
