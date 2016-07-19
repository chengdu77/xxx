//
//  NewsViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "NewsViewController.h"
#import "PullingRefreshTableView.h"
#import "WorkOrderCell.h"

static NSString *tableViewIdentifier = @"WorkOrderCell";

@interface NewsViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    
    PullingRefreshTableView *_tableView;
    
    NSMutableArray *newsArray;//消息数据
    NSInteger pageNumber;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    newsArray = [NSMutableArray array];
    NSDictionary *data = @{@"title":@"华西医院名列复旦最佳医院第二名",@"detail":@"中国最佳医院排行榜上在上海发布了“年度中国最佳医院排行榜”",@"time":@"12-10 23:11",@"count":@"20"};
    [newsArray addObject:data];
    
    data = @{@"title":@"卓越基层影像医生培训班举行",@"detail":@"为响应发展基层医疗的号召，“卓越基层影像医生”培训启动",@"time":@"16-10 23:11",@"count":@"999"};
    [newsArray addObject:data];
    
    [self initThisView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    CGRect frame = CGRectMake(0,0,self.viewWidth,156);
    UIView *headView = [[UIView alloc] initWithFrame:frame];
    UIImageView *hospitolImageView = [[UIImageView alloc] initWithFrame:frame];
    hospitolImageView.image = nil;
    [headView addSubview:hospitolImageView];
    [self.scrollView addSubview:headView];
    
    _tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.frame)+5,self.viewWidth,self.viewHeight - CGRectGetMaxY(headView.frame)) pullingDelegate:self];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nib=[UINib nibWithNibName:tableViewIdentifier bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:tableViewIdentifier];
    
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
    return newsArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 90;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (cell == nil) {
        cell = [[WorkOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIdentifier];
    }
    
    NSDictionary *data = newsArray[indexPath.row];
    cell.photoImageView.image = [UIImage imageNamed:@"image_icon"];
    cell.titleLabel.text = data[@"title"];
    cell.detailLabel.text = data[@"detail"];
    cell.timeLabel.text = data[@"time"];
    cell.countLabel.text = data[@"count"];
    
    cell.detailLabel.textColor = kFontColor;
    cell.timeLabel.textColor = kFontColor;
    cell.countLabel.textColor = kFontColor;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    pageNumber++;
    [self reloadDataWithPageNumber:pageNumber];;
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
