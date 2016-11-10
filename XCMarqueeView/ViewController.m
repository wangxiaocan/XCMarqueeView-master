//
//  ViewController.m
//  XCMarqueeView
//
//  Created by wangwenke on 16/9/14.
//  Copyright © 2016年 wangwenke. All rights reserved.
//

#import "ViewController.h"

#import "XCMarqueeView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) XCMarqueeView *raceView;
@property (nonatomic, strong) UITableView *racetabelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _raceView = [[XCMarqueeView alloc]initWithFrame:CGRectMake(10.0, 60.0, 60.0, 30.0) andRaceTitle:@"中秋节马上就要来了，祝各位中秋快乐！！！........."];
    _raceView.backgroundColor = [UIColor blackColor];
    
    _racetabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _racetabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _racetabelView.dataSource = self;
    _racetabelView.delegate = self;
    [self.view addSubview:_racetabelView];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _racetabelView.frame = self.view.bounds;
    [_racetabelView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"header"];
    }
    headerView.textLabel.text = @"Race Label";
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (![cell.contentView.subviews containsObject:_raceView] && indexPath.row == 0) {
        _raceView.frame = cell.contentView.bounds;
        [cell.contentView addSubview:_raceView];
    }
    _raceView.frame = cell.bounds;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end