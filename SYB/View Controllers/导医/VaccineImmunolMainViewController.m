//
//  VaccineImmunolMainViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/13.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "VaccineImmunolMainViewController.h"
#import "TPCPageScrollView.h"
#import "SearchViewController.h"
#import "UserCenterViewController.h"
#import "UIView+BindValues.h"
#import "HospitolViewController.h"
#import "OfficeViewController.h"
#import "ExpertViewController.h"
#import "NewsViewController.h"
#import "AddressViewController.h"
#import "ContackViewController.h"

@interface VaccineImmunolMainViewController (){
    
    TPCPageScrollView *pageScrollView;
}


@property (weak, nonatomic) TPCPageScrollView *pageView;
@property (strong, nonatomic) NSArray *images;

@end

@implementation VaccineImmunolMainViewController

- (void)viewDidLoad {
    self.hasTabBarFlag = YES;
    [super viewDidLoad];
    
    
    [self initPageScrollView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    CGRect frame = CGRectMake(0,0,self.viewWidth, 46);
    UIView *headView = [self searchViewWithFrame:frame];
    [self.scrollView addSubview:headView];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.view.bounds.size.width,156);
    pageScrollView.frame = frame;
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+1,self.viewWidth, 56);
    UIImage *hospitol = [UIImage imageNamed:@"navigation_hospitol"];
    UIImage *office = [UIImage imageNamed:@"navigation_office"];
    UIImage *expert = [UIImage imageNamed:@"navigation_expert"];
    UIImage *news = [UIImage imageNamed:@"navigation_news"];
    UIImage *address = [UIImage imageNamed:@"navigation_address"];
    UIImage *contack = [UIImage imageNamed:@"navigation_contack"];
    NSArray *valuesArray = @[@"关于医院",@"科室介绍",@"专家介绍",@"最新消息",@"地址指南",@"联系方式"];
    NSArray *imageArrays =@[hospitol,office,expert,news,address,contack];
    int h = 1;//控制行间距
    for(NSUInteger i = 0;i < valuesArray.count;i++){
        NSString *title = valuesArray[i];
        UIImage *image = imageArrays[i];
        UIView *testView = [self drawListView:frame title:title image:image action:@selector(listDataClicked:) tag:i];
        [self.scrollView addSubview:testView];
        if (i < valuesArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 56);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
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

- (void)initPageScrollView{
    pageScrollView = TPCPageScrollView.new;
    
    pageScrollView.pagingInterval = 5.0;
    [pageScrollView startAutoPaging];
    [self.scrollView addSubview:pageScrollView];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        AppDelegate *app = [UIApplication sharedApplication].delegate;
    pageScrollView.images = [self images];
    //        app.images = nil;
    //    });
    
    self.pageView = pageScrollView;
    self.pageView.currentPageColor = kRandomColor;
    self.pageView.otherPageColor = kRandomColor;
}


- (NSArray *)images{
    if (nil == _images) {
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
        
        for (int i = 0; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"tab%d.png", i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [images addObject:image];
        }
        self.images = images;
    }
    
    return _images;
}

- (UIView *)drawListView:(CGRect)frame title:(NSString *)title image:(UIImage *)image action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.value = title;
    view.tag = tag;
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(15, (56-30)/2,30, 30);
    imageView.image = image;
    [view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(48, 8,150, 40);
    label.text = title;
    label.textColor = kFontColor_Contacts;
    label.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label];
    
    UIImageView *jtImageView = [UIImageView new];
    jtImageView.frame = CGRectMake(self.viewWidth-40, 13,30, 30);
    jtImageView.image = [UIImage imageNamed:@"箭头"];
    [view addSubview:jtImageView];
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}


- (void)listDataClicked:(UITapGestureRecognizer *)sender{
    
    NSInteger tag = sender.view.tag;
    NSString *title = sender.view.value;
    HeadViewController *tempVC;
    switch (tag) {
        case 0:
            tempVC = HospitolViewController.new;
            break;
        case 1:
            tempVC = OfficeViewController.new;
            break;
        case 2:
            tempVC = ExpertViewController.new;
            break;
        case 3:
            tempVC = NewsViewController.new;
            break;
        case 4:
            tempVC = AddressViewController.new;
            break;
        case 5:
            tempVC = ContackViewController.new;
            break;
    }
    
    tempVC.title = title;
    [self.navigationController pushViewController:tempVC animated:YES];
    
}


@end
