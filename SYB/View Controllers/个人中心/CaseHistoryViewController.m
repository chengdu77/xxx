//
//  CaseHistoryViewController.m
//  SLYLT
//
//  Created by WangJincai on 16/6/7.
//  Copyright © 2016年 Shenlan.com. All rights reserved.
//

#import "CaseHistoryViewController.h"
#import "AddCaseHistoryViewController.h"
#import "CaseHistoryListViewController.h"

@interface CaseHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>{
//    UISearchBar *_searchBar;
    UITableView *_tableView;

    NSArray *valueArray;
}

@end

@implementation CaseHistoryViewController

- (void)viewDidLoad {
     self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    valueArray = @[@{@"patientName":@"李磊",@"patientId":@"NO.634654654121"},@{@"patientName":@"韩梅梅",@"patientId":@"NO.6346689546124721"}];

    [self initThisView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    if (_tableView) {
        [_tableView removeFromSuperview];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.scrollView addSubview:_tableView];
    _tableView.backgroundColor = kBackgroundColor;
    
//    if (_searchBar) {
//        [_searchBar removeFromSuperview];
//    }
//    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 44)];
//    _tableView.tableHeaderView = _searchBar;
//    //            _searchBar.showsScopeBar = YES;
////    _searchBar.delegate = self;
//    _searchBar.placeholder = @"请输入患者手机号码进行查询";
    
    [_tableView reloadData];
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0,self.viewHeight -56,self.viewWidth,56)];
    [self.view addSubview:btnView];
    
    CGRect tFrame =CGRectMake(10,8,self.viewWidth -20,40);
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = tFrame;
    addButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    addButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [addButton setTitle:@"新建病历" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setBackgroundColor:kALL_COLOR];
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:addButton];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kCellHeight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return valueArray.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tableViewIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewIdentifier];
    }
    
    NSDictionary *info = valueArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = info[@"patientName"];
    cell.textLabel.font = [UIFont fontWithName:kFontName size:16.0];
    
    cell.detailTextLabel.text = info[@"patientId"];
    cell.detailTextLabel.font = [UIFont fontWithName:kFontName size:12.0];
    cell.detailTextLabel.textColor = kFontColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CaseHistoryListViewController *caseHistoryListViewController = [CaseHistoryListViewController new];
    [self.navigationController pushViewController:caseHistoryListViewController animated:YES];
}

- (void)addAction:(UIButton *)sender{
    
    AddCaseHistoryViewController *addCaseHistoryViewController = AddCaseHistoryViewController.new;
    [self.navigationController pushViewController:addCaseHistoryViewController animated:YES];
    
}


@end
