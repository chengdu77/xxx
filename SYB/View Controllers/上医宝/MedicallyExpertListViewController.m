//
//  MedicallyExpertListViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/23.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MedicallyExpertListViewController.h"
#import "LeaveSlideView.h"
#import "ExpertTableViewCell.h"
#import "ExpertDetailsViewController.h"


@interface MedicallyExpertListViewController (){
    NSMutableArray *tempArray;
    NSInteger defaultTag;//默认选择按钮标识
    NSInteger page;
}
@property (strong, nonatomic) LeaveSlideView *slideView;


@end

@implementation MedicallyExpertListViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    tempArray = [NSMutableArray array];
    [tempArray addObject:@[@{@"name":@"郭应强"}]];
    [tempArray addObject:@[@{@"name":@"王晓东"},@{@"name":@"文天夫"},@{@"name":@"賃可"}]];
    
    page = 1;
    defaultTag = 0;
    
    [self requestDataTag:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initSlideView{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    
    NSArray *array = @[@"普通门诊",@"专家门诊",@"特需门诊"];
    if (_slideView) {
        [_slideView removeFromSuperview];
    }
    _slideView = [[LeaveSlideView alloc] initWithFrame:screenBound withTitles:array slideColor:kALL_COLOR withObjects:tempArray cellName:@"ExpertTableViewCell" errorImage:[UIImage imageNamed:@"无公告"] errorInfos:@[@"暂无门诊信息",@"暂无门诊信息",@"暂无门诊信息"]];
    _slideView.cellName = @"ExpertTableViewCell";
    _slideView.cellHeight = 90;
    _slideView.headerInSectionHeight = 34;
    _slideView.footerInSectionHeight = 5;
    _slideView.delegate = self;
    
    [self.scrollView addSubview:_slideView];
    
    [_slideView defaultAction:defaultTag];
}

- (UIView *)drawTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,_slideView.headerInSectionHeight)];
    header.backgroundColor = [UIColor whiteColor];
    
    NSString *desc = @"该科室的其他医生";
    CGRect frame = CGRectMake(10,6,self.viewWidth-10,20);
    if (section == 0) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,6,30,20)];
        tempLabel.text = @"推荐";
        tempLabel.backgroundColor = RGB(253, 207, 67);
        tempLabel.textColor = [UIColor whiteColor];
        tempLabel.font = [UIFont fontWithName:kFontName size:14];
        
        [header addSubview:tempLabel];
        
        frame = CGRectMake(35, 6,self.viewWidth-10,20);
         desc = @"这位医生为您看病";
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = desc;
    label.font = [UIFont fontWithName:kFontName size:14];
    [header addSubview:label];
    
    return header;
}

- (UITableViewCell *)fillCellDataTableView:(UITableView *)tableView withObject:(id)object withPageTag:(NSInteger)_page {
    
    ExpertTableViewCell *cell = (ExpertTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ExpertTableViewCell"];
    if (!cell) {
        cell = [[ExpertTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ExpertTableViewCell"];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    NSDictionary *info = object;
    cell.nameLabel.text = info[@"name"];
    
    return cell;
}

//打开详情
- (void)openInfoViewWith:(id)object withPageTag:(NSInteger)_page{
    
//    NSDictionary *info = object;
    
    ExpertDetailsViewController *expertDetailsViewController = ExpertDetailsViewController.new;
    [self.navigationController pushViewController:expertDetailsViewController animated:YES];
    
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
