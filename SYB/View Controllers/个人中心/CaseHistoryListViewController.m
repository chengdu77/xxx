//
//  CaseHistoryListViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "CaseHistoryListViewController.h"
#import "CaseHistoryDetailViewController.h"
#import "PullingRefreshTableView.h"
#import "CaseHistoryCell.h"

@interface CaseHistoryListViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    
    PullingRefreshTableView *_tableView;
    
    NSMutableArray *listArray;//数据
    
    NSInteger pageNumber;
}

@end

@implementation CaseHistoryListViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    self.title = @"查处方单";
    listArray = [NSMutableArray array];
    pageNumber = 1;
    NSDictionary *data = @{@"id":@"00",@"dept":@"产科",@"patient":@"韩梅梅",@"time":@"2014-12-04"};
    [listArray addObject:data];
    
    data = @{@"id":@"01",@"dept":@"精神科",@"patient":@"李磊",@"time":@"2014-12-04"};
    [listArray addObject:data];
    
    data = @{@"id":@"02",@"dept":@"产科",@"patient":@"李磊",@"time":@"2014-12-04"};
    [listArray addObject:data];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{

    _tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,self.viewHeight) pullingDelegate:self];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nib=[UINib nibWithNibName:@"CaseHistoryCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"CaseHistoryCell"];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self reloadData];
    
    [self.scrollView addSubview:_tableView];
}

#pragma mark -- talbeView的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CaseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaseHistoryCell"];
    if (cell == nil) {
        cell = [[CaseHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CaseHistoryCell"];
    }
    
    NSDictionary *data = listArray[indexPath.row];
    cell.serialLabel.text = [NSString stringWithFormat:@"编号\n%@",data[@"id"]];
    cell.deptLabel.text = data[@"dept"];
    cell.patientLabel.text = data[@"patient"];
    cell.timeLabel.text = data[@"time"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CaseHistoryDetailViewController *caseHistoryDetailViewController = CaseHistoryDetailViewController.new;
    caseHistoryDetailViewController.title = self.title;
    [self.navigationController pushViewController:caseHistoryDetailViewController animated:YES];
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    pageNumber++;
    [self reloadDataWithPageNumber:pageNumber];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *currentDateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:currentDateStr];
    return date;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    pageNumber++;
    [self reloadDataWithPageNumber:pageNumber];
}

- (void)reloadData{
    
    [_tableView reloadData];
    [_tableView tableViewDidFinishedLoading];
    _tableView.reachedTheEnd = NO;
    
}

- (void)reloadDataWithPageNumber:(NSInteger)pageNum{
    
//    [self requestData:NO];
    
}


//拖拽后调用的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_tableView tableViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_tableView tableViewDidScroll:scrollView];
}


@end
