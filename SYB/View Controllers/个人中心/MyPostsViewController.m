//
//  MyPostsViewController.m
//  SYB
//
//  Created by WangJincai on 16/7/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MyPostsViewController.h"
#import "LeaveSlideView.h"
#import "UIView+BindValues.h"
#import "MyPostsCell.h"
#import "CirclePostsViewController.h"
#import "PostDetailsViewController.h"

@interface MyPostsViewController ()<LeaveSlideViewDelegate>{
    NSInteger defaultTag;//默认选择按钮标识
    NSInteger page;
    
    NSMutableArray *tempArray;
    NSArray *array;
}

@property (strong, nonatomic) LeaveSlideView *slideView;
@end

@implementation MyPostsViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    tempArray = [NSMutableArray array];
    defaultTag = 0;
    page = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [tempArray removeAllObjects];
    [self requestData];
}

- (void)initSlideView:(NSArray *)tmpArray{
    
    CGRect screenBound = CGRectMake(0,0,self.viewWidth,self.viewHeight);
    
    array = @[@"我的主题",@"我的回复"];
    NSMutableArray *errorInfos = [NSMutableArray array];
    for (int i = 0;i < array.count;i++) {
        [errorInfos addObject:@"暂无帖子信息"];
    }
    
    if (_slideView) {
        [_slideView removeFromSuperview];
    }
    _slideView = [[LeaveSlideView alloc] initWithFrame:screenBound withTitles:array slideColor:kALL_COLOR withObjects:tmpArray cellName:@"MyPostsCell" errorImage:[UIImage imageNamed:@"无公告"] errorInfos:errorInfos];
    _slideView.cellName = @"MyPostsCell";
    _slideView.delegate = self;
    
    [self.scrollView addSubview:_slideView];
    
    [_slideView defaultAction:defaultTag];
}

- (CGFloat)drawTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *info = tempArray[indexPath.row];
    CGFloat cellHeight = [info[@"CellHeight"] floatValue];
    return cellHeight>0?cellHeight:80;
}

- (UITableViewCell *)fillCellDataTableView:(UITableView *)tableView withObject:(id)object withPageTag:(NSInteger)_page {
    
    MyPostsCell *cell = (MyPostsCell *)[tableView dequeueReusableCellWithIdentifier:@"MyPostsCell"];
    if (!cell) {
        cell = [[MyPostsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyPostsCell"];
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    NSDictionary *info = object;
    UIView *view = [self listViewWithFrame:CGRectMake(0, 0, self.viewWidth,80) data:info];
    [cell addSubview:view];
    
    NSInteger index = [tempArray indexOfObject:object];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
    [dic setObject:@(CGRectGetHeight(view.frame)) forKey:@"CellHeight"];
    [tempArray replaceObjectAtIndex:index withObject:dic];
    
    return cell;
}

//打开详情
- (void)openInfoViewWith:(id)object withPageTag:(NSInteger)tag{
    
    NSDictionary *info = object;
    
    if (tag == 0){
        CirclePostsViewController *circlePostsViewController = CirclePostsViewController.new;
        circlePostsViewController.title = array[defaultTag];
        circlePostsViewController.moduleId = info[@"module_id"];
        circlePostsViewController.info = info;
        [self.navigationController pushViewController:circlePostsViewController animated:YES];
    }else{

        PostDetailsViewController *postDetailsViewController = PostDetailsViewController.new;
        postDetailsViewController.content = info[@"des"];
        postDetailsViewController.Id = info[@"id"];
        postDetailsViewController.moduleId = info[@"module_id"];
        postDetailsViewController.title_ = info[@"title"];
        [self.navigationController pushViewController:postDetailsViewController animated:YES];
    }
}

- (void)reloadDataWithPageTag:(NSInteger)tag withPageNumber:(NSInteger)pageNum{
    
    page = pageNum;

    if (defaultTag != tag) {
        [tempArray removeAllObjects];
    }
    
    [self requestDataTag:tag];
}

- (void)requestDataTag:(NSUInteger)tag{
    
   
    
    defaultTag = tag;//默认选择按钮标识

    [self requestData];
    
}

- (UIView *)listViewWithFrame:(CGRect)frame data:(NSDictionary *)data{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.value = data;
    
    CGRect tFrame = CGRectMake(5,5,self.viewWidth-10,20);
    UILabel *desLabel = [self adaptiveLabelWithFrame:tFrame detail:data[@"des"] fontSize:14];
    [view addSubview:desLabel];
    tFrame = desLabel.frame;
    
    UIImageView *txImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,CGRectGetMaxY(tFrame)+5, 18, 18)];
    [self setImageWithURL:data[@"puser"][@"icon"] imageView:txImageView placeholderImage:[UIImage imageNamed:@"image_icon"]];
    [self roundImageView:txImageView withColor:nil];
    [view addSubview:txImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(txImageView.frame)+5,CGRectGetMaxY(tFrame)+5, 120, 18)];
    nameLabel.font = [UIFont fontWithName:kFontName size:12];
    nameLabel.textColor = kFontColor;
    nameLabel.text = data[@"puser"][@"realname"];
    [view addSubview:nameLabel];
    
    NSString *create_time = data[@"create_time"];
    NSRange range = {5,5};
    create_time = [create_time substringWithRange:range];
    
    UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewWidth-110,CGRectGetMaxY(tFrame)+5, 18, 18)];
    timeImageView.image = [UIImage imageNamed:@"my_consult_time"];
    [view addSubview:timeImageView];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeImageView.frame)+5,CGRectGetMaxY(tFrame)+5,35, 18)];
    timeLabel.font = [UIFont fontWithName:kFontName size:12];
    timeLabel.textColor = kFontColor;
    timeLabel.text = create_time;
    [view addSubview:timeLabel];
    
    UIImageView *msgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame)+2,CGRectGetMaxY(tFrame)+5, 18, 18)];
    msgImageView.image = [UIImage imageNamed:@"topicimg"];
    [view addSubview:msgImageView];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(msgImageView.frame)+5,CGRectGetMaxY(tFrame)+5,40, 18)];
    msgLabel.font = [UIFont fontWithName:kFontName size:12];
    msgLabel.textColor = kFontColor;
    msgLabel.text = [NSString stringWithFormat:@"%@",data[@"revert_count"]];
    [view addSubview:msgLabel];
    
    frame.size.height = CGRectGetHeight(tFrame) +33;
    view.frame = frame;
    
//    view.userInteractionEnabled = YES;
//    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listViewCliecked:)];
//    [view addGestureRecognizer:viewTapGesture];
    
    return view;
    
}

//topic int (必须 1:发帖2:回复)
- (void)requestData{
    
    NSInteger topic = defaultTag +1;
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    NSDictionary *parameters = @{@"page":@(page),@"topic":@(topic)};
    [ContactsRequest bbsContentMyRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        NSMutableArray *data = response.message[@"result"];
        [tempArray addObjectsFromArray:data];
        
        if (defaultTag == 0) {
            [self initSlideView:tempArray];
        }else{
             [_slideView reloadViewWithData:tempArray index:defaultTag];
        }
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];

}

@end
