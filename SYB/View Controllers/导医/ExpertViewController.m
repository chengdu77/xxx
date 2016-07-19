//
//  ExpertViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ExpertViewController.h"
#import "ExpertTableViewCell.h"
#import "ExpertDetailsViewController.h"
#import "CustomHeaderView.h"


static NSString *tableViewIdentifier = @"ExpertTableViewCell";

@interface ExpertViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    
    NSMutableArray *_options;
}

@end

@implementation ExpertViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    _options = [NSMutableArray array];
    [_options addObject:@{@"name":@"郭应强"}];
    [self initThisView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    if (_tableView) {
        [_tableView removeFromSuperview];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.scrollView addSubview:_tableView];
    _tableView.backgroundColor = kBackgroundColor;
    
    UINib *nib = [UINib nibWithNibName:tableViewIdentifier bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:tableViewIdentifier];
    
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _options.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExpertTableViewCell *cell = (ExpertTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (!cell) {
        cell = [[ExpertTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIdentifier];
    }
    
    NSDictionary *info = _options[indexPath.row];
    cell.nameLabel.text = info[@"name"];
    
    NSLog(@"frame:%@",NSStringFromCGRect(cell.bounds));

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = _options[indexPath.row];
    if (self.style == ExpertStyleChoose) {
        self.block(info[@"name"]);
        [self backAction];
        return;
    }
    
    ExpertDetailsViewController *expertDetailsViewController = ExpertDetailsViewController.new;
    [self.navigationController pushViewController:expertDetailsViewController animated:YES];
}

- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block{
    self.block = block;
}



@end
