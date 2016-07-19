//
//  CircleMainViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/13.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "CircleMainViewController.h"
#import "SearchViewController.h"
#import "UserCenterViewController.h"
#import "LeaveSlideView.h"
#import "CircleCell.h"

@interface CircleMainViewController (){
    NSMutableArray *tempArray;
    NSInteger defaultTag;//默认选择按钮标识
    NSInteger page;
}

@property (strong, nonatomic) LeaveSlideView *slideView;

@end

@implementation CircleMainViewController

- (void)viewDidLoad {
    self.hasTabBarFlag = YES;
    [super viewDidLoad];
    
    tempArray = [NSMutableArray array];
    [tempArray addObject:@{@"name":@"整形美容科",@"icon":@"icon_beauty",@"msg":@"98",@"user":@"38"}];
    [tempArray addObject:@{@"name":@"新生儿科",@"icon":@"icon_children",@"msg":@"908",@"user":@"309"}];
    [tempArray addObject:@{@"name":@"内科",@"icon":@"icon_in",@"msg":@"457",@"user":@"124"}];
    [tempArray addObject:@{@"name":@"神经外科",@"icon":@"icon_out",@"msg":@"894",@"user":@"832"}];
    [tempArray addObject:@{@"name":@"心血管科",@"icon":@"icon_heart",@"msg":@"854",@"user":@"638"}];
    [tempArray addObject:@{@"name":@"心血管科2",@"icon":@"icon_heart",@"msg":@"854",@"user":@"638"}];
    
    page = 1;
    defaultTag = 0;
    
    [self requestDataTag:0];
    
    [self initThisView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)initThisView{
    CGRect frame = CGRectMake(0,0,self.viewWidth, 46);
    UIView *headView = [self searchViewWithFrame:frame];
    [self.scrollView addSubview:headView];


}

#pragma mark 点击个人中心
- (void)userCenterClicked:(UITapGestureRecognizer *)sender{
    
    UserCenterViewController *userCenterViewController = UserCenterViewController.new;
    
    [self.navigationController pushViewController:userCenterViewController animated:YES];
    
}

#pragma mark 点击查询
- (void)searchClicked:(UITapGestureRecognizer *)sender{
    SearchViewController *searchViewController = SearchViewController.new;
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)initSlideView{
    
    CGRect screenBound = CGRectMake(0,46,self.viewWidth,self.viewHeight -46);
    
    NSArray *array = @[@"病友圈",@"医院圈",@"健康生活",@"情感"];
    if (_slideView) {
        [_slideView removeFromSuperview];
    }
    _slideView = [[LeaveSlideView alloc] initWithFrame:screenBound withTitles:array slideColor:kALL_COLOR withObjects:tempArray cellName:@"CircleCell" errorImage:[UIImage imageNamed:@"无公告"] errorInfos:@[@"暂无圈子信息",@"暂无圈子信息",@"暂无圈子信息",@"暂无圈子信息"]];
    _slideView.cellName = @"CircleCell";
    _slideView.cellHeight = 80;
    _slideView.delegate = self;
    
    [self.scrollView addSubview:_slideView];
    
    [_slideView defaultAction:defaultTag];
}

- (UITableViewCell *)fillCellDataTableView:(UITableView *)tableView withObject:(id)object withPageTag:(NSInteger)_page {
    
    CircleCell *cell = (CircleCell *)[tableView dequeueReusableCellWithIdentifier:@"CircleCell"];
    if (!cell) {
        cell = [[CircleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CircleCell"];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    NSDictionary *info = object;
    
    cell.nameLabel.text = info[@"name"];
    cell.iconView.image = [UIImage imageNamed:info[@"icon"]];
    cell.msgLabel.text = info[@"msg"];
    cell.userLabel.text = info[@"user"];
    
    return cell;
    
}

//打开详情
- (void)openInfoViewWith:(id)object withPageTag:(NSInteger)_page{
    
    //    NSDictionary *info = object;
//    ExpertDetailsViewController *expertDetailsViewController = ExpertDetailsViewController.new;
//    [self.navigationController pushViewController:expertDetailsViewController animated:YES];
    
}

- (void)reloadDataWithPageTag:(NSInteger)_page withPageNumber:(NSInteger)pageNum{
    
    page = pageNum;
    
    [self requestDataTag:_page];
}

- (void)requestDataTag:(NSUInteger)tag{
    
    defaultTag = tag;//默认选择按钮标识
    if (defaultTag == 0) {
        [self initSlideView];
    }else{
        [_slideView reloadViewWithData:tempArray index:defaultTag];
    }
}

@end
