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
#import "CirclePostsViewController.h"

@interface CircleMainViewController (){
    NSMutableArray *circleTitle;
    NSMutableArray *circleParent;
    NSMutableDictionary *circleChild;
    NSInteger defaultTag;//默认选择按钮标识
    NSInteger page;
}

@property (strong, nonatomic) LeaveSlideView *slideView;

@end

@implementation CircleMainViewController

- (void)viewDidLoad {
    self.hasTabBarFlag = YES;
    [super viewDidLoad];
    
    circleTitle = [NSMutableArray array];
    circleParent = [NSMutableArray array];
    circleChild = [NSMutableDictionary dictionary];
    
    page = 1;
    defaultTag = 0;
    [self initThisView];
    [self requestBbsModuleData];
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


- (void)requestBbsModuleData{

    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    NSString *entId = [[NSUserDefaults standardUserDefaults] objectForKey:kEntId];
    
    NSDictionary *parameters = @{@"entId":entId};
    [ContactsRequest bbsModuleRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        NSArray *data = response.messages;
        for (int i=0;i<data.count;i++) {
            NSDictionary *info = data[i];
            NSString *moduleId = info[@"id"];
            [circleTitle addObject:info[@"name"]];
            [circleParent addObject:moduleId];
            [self requestBbsModuleChildDataWith:moduleId];
        }
    
        if (circleTitle.count >0) {
       
        }else{
            [MBProgressHUD showError:@"没有圈子数据" toView:ShareAppDelegate.window];
        }
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];
}

- (void)requestBbsModuleChildDataWith:(NSString *)moduleId{
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *parameters = @{@"moduleId":moduleId};
        [ContactsRequest bbsModuleChildRequestParameters:parameters success:^(PiblicHttpResponse *response) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
                NSArray *data = response.messages;
                [circleChild setObject:data forKey:moduleId];
                
                NSInteger index = [circleParent indexOfObject:moduleId];
                if (index == 0) {
                     [self initSlideView:data];
                }
                 });
            
        } fail:^(BOOL notReachable, NSString *desciption) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
                [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
                });
        }];
        
    });
}

- (void)initSlideView:(NSArray *)tempArray{
    
    CGRect screenBound = CGRectMake(0,46,self.viewWidth,self.viewHeight -46);
    
    NSArray *array = circleTitle;
    NSMutableArray *errorInfos = [NSMutableArray array];
    for (int i = 0;i < array.count;i++) {
        [errorInfos addObject:@"暂无圈子信息"];
    }
    
    if (_slideView) {
        [_slideView removeFromSuperview];
    }
    _slideView = [[LeaveSlideView alloc] initWithFrame:screenBound withTitles:array slideColor:kALL_COLOR withObjects:tempArray cellName:@"CircleCell" errorImage:[UIImage imageNamed:@"无公告"] errorInfos:errorInfos];
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
    
    //    [tempArray addObject:@{@"name":@"整形美容科",@"icon":@"icon_beauty",@"msg":@"98",@"user":@"38"}];
    //    [tempArray addObject:@{@"name":@"新生儿科",@"icon":@"icon_children",@"msg":@"908",@"user":@"309"}];
    //    [tempArray addObject:@{@"name":@"内科",@"icon":@"icon_in",@"msg":@"457",@"user":@"124"}];
    //    [tempArray addObject:@{@"name":@"神经外科",@"icon":@"icon_out",@"msg":@"894",@"user":@"832"}];
    //    [tempArray addObject:@{@"name":@"心血管科",@"icon":@"icon_heart",@"msg":@"854",@"user":@"638"}];
    //    [tempArray addObject:@{@"name":@"心血管科2",@"icon":@"icon_heart",@"msg":@"854",@"user":@"638"}];
    
    cell.nameLabel.text = info[@"name"];
    [self setImageWithURL:info[@"icon"] imageView:cell.iconView placeholderImage:[UIImage imageNamed:@"icon_beauty"]];
    cell.msgLabel.text = info[@"msg"]?info[@"msg"]:@"0";
    cell.userLabel.text = info[@"user"]?info[@"user"]:@"0";
    
    return cell;
}

//打开详情
- (void)openInfoViewWith:(id)object withPageTag:(NSInteger)_page{
    
    NSDictionary *info = object;
    
    NSString *moduleId = circleParent[defaultTag];
//    NSLog(@"_page:%@ defaultTag:%@ moduleId:%@ id:%@",@(_page),@(defaultTag),moduleId,info[@"id"]);
    
    CirclePostsViewController *circlePostsViewController = CirclePostsViewController.new;
    circlePostsViewController.title = circleTitle[defaultTag];
    circlePostsViewController.moduleId = moduleId;
    circlePostsViewController.info = info;
    [self.navigationController pushViewController:circlePostsViewController animated:YES];
    
}

- (void)reloadDataWithPageTag:(NSInteger)_page withPageNumber:(NSInteger)pageNum{
    
    page = pageNum;
    
    [self requestDataTag:_page];
}

- (void)requestDataTag:(NSUInteger)tag{
    
    NSString *moduleId = circleParent[defaultTag];
    NSArray *tempArray = circleChild[moduleId];
    
    defaultTag = tag;//默认选择按钮标识
    if (defaultTag == 0 && tempArray.count >0) {
        [self initSlideView:tempArray];
    }else{
        [_slideView reloadViewWithData:tempArray index:defaultTag];
    }
}

@end
