//
//  AccessReportDetailViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/24.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "AccessReportDetailViewController.h"

@interface AccessReportDetailViewController (){
    
    UIView *expandView;
    UIView *footerView;
    
    NSArray *headArray;
    NSArray *expandArray;
    NSArray *detailArray;
    BOOL expandFlag;
}

@end

@implementation AccessReportDetailViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    headArray = @[@{@"title":@"检查项目",@"value":@"雪常规"},@{@"title":@"姓       名",@"value":@"韩梅梅"}];
    expandArray = @[
  @{@"title":@"年       龄",@"value":@"35"},
  @{@"title":@"门诊科室",@"value":@"内科"},
  @{@"title":@"检查科室",@"value":@"CT室"},
  @{@"title":@"检查医师",@"value":@"郭应强"}];
    
    detailArray = @[@{@"item":@"项目",@"result":@"结果",@"parameter":@"参考值"},
                    @{@"item":@"血红蛋白",@"result":@"150.0",@"parameter":@"120-160g/L"},
                    @{@"item":@"磕酸粒细胞",@"result":@"330.0",@"parameter":@"50-300个/mm3"},
                    @{@"item":@"白细胞（WBC）计数",@"result":@"8000.0",@"parameter":@"4000-10000/L"}
                    ];
    expandFlag = NO;
    [self initThisView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UILabel *zhuLabel = [[UILabel alloc] initWithFrame:frame];
    zhuLabel.text = @"   个人信息";
    zhuLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:zhuLabel];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame),self.viewWidth, 40);
    int h = 0;//控制行间距
    for(NSUInteger i = 0;i < headArray.count;i++){
        NSDictionary *data = headArray[i];
        UIView *testView = [self childViewWithFrame:frame data:data];
        [self.scrollView addSubview:testView];
        if (i < headArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 40);
        }
    }
    frame = CGRectMake(0, CGRectGetMaxY(frame),self.viewWidth,0);
    expandView = [[UIView alloc] initWithFrame:frame];
    [self.scrollView addSubview:expandView];
    [expandView setHidden:!expandFlag];
    CGRect tempFrame = CGRectMake(0,0,self.viewWidth, 40);
    for(NSUInteger i = 0;i < expandArray.count;i++){
        NSDictionary *data = expandArray[i];
        UIView *testView = [self childViewWithFrame:tempFrame data:data];
        [expandView addSubview:testView];
        if (i < expandArray.count-1) {
            tempFrame = CGRectMake(0, CGRectGetMaxY(tempFrame),self.viewWidth, 40);
        }
    }
    
    frame = CGRectMake(0, CGRectGetMaxY(frame),self.viewWidth,(detailArray.count+2)*40+1);
    footerView = [[UIView alloc] initWithFrame:frame];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:footerView];
    
    tempFrame = CGRectMake(10,0,self.viewWidth-20,1);
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:tempFrame];
    lineLabel.backgroundColor = kBackgroundColor;
    [footerView addSubview:lineLabel];

    tempFrame = CGRectMake(0,1,self.viewWidth, 40);
    UIView *tView = [[UIView alloc] initWithFrame:tempFrame];
    [footerView addSubview:tView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewWidth -70,0,60, 40)];
    textLabel.text = @"展开更多";
    textLabel.tag = 3000;
    textLabel.textColor = kALL_COLOR;
    textLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tView addSubview:textLabel];
    
    tView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked)];
    [tView addGestureRecognizer:tapGesture];
    
    tempFrame = CGRectMake(0,CGRectGetMaxY(tempFrame),self.viewWidth, 40);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:tempFrame];
    titleLabel.text = @"   检查结果";
    titleLabel.font = [UIFont fontWithName:kFontName size:16.0];
    titleLabel.backgroundColor = kBackgroundColor;
    [footerView addSubview:titleLabel];
    
    tempFrame = CGRectMake(0,CGRectGetMaxY(tempFrame),self.viewWidth, 40);
    for(NSUInteger i = 0;i < detailArray.count;i++){
        NSDictionary *data = detailArray[i];
        UIView *testView = [self listViewWithFrame:tempFrame data:data index:i];
        [footerView addSubview:testView];
        if (i < detailArray.count-1) {
            tempFrame = CGRectMake(0, CGRectGetMaxY(tempFrame),self.viewWidth, 40);
        }
    }
}

- (UIView *)childViewWithFrame:(CGRect)frame data:(NSDictionary *)data{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, (CGRectGetHeight(frame)-20)/2,80, 20);
    titleLabel1.text = data[@"title"];
    titleLabel1.textColor = kFontColor;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:titleLabel1];
    
    UILabel *valueLabel = [UILabel new];
    valueLabel.frame = CGRectMake(80, (CGRectGetHeight(frame)-20)/2,self.viewWidth-90, 20);
    valueLabel.text = data[@"value"];
    valueLabel.textColor = kFontColor_Contacts;
    valueLabel.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:valueLabel];
    
    return view;
}

- (UIView *)listViewWithFrame:(CGRect)frame data:(NSDictionary *)data index:(NSUInteger)index{
    
    UIView *view = [UIView new];
    view.backgroundColor = ((index+1)%2 == 1)?RGB(245, 248, 253):[UIColor whiteColor];
    view.frame = frame;
    
    UILabel *itemLabel = [UILabel new];
    itemLabel.frame = CGRectMake(5, (CGRectGetHeight(frame)-20)/2,130, 20);
    itemLabel.text = data[@"item"];
    itemLabel.textColor = (index==0?kALL_COLOR:kFontColor_Contacts);
    itemLabel.font = [UIFont fontWithName:kFontName size:12];
    [view addSubview:itemLabel];
    
    UILabel *resultLabel = [UILabel new];
    resultLabel.frame = CGRectMake(130, (CGRectGetHeight(frame)-20)/2,90, 20);
    resultLabel.text = data[@"result"];
    resultLabel.textColor = (index==0?kALL_COLOR:kFontColor_Contacts);
    resultLabel.font = [UIFont fontWithName:kFontName size:12];
    [view addSubview:resultLabel];
    
    UILabel *parameterLabel = [UILabel new];
    parameterLabel.frame = CGRectMake(220, (CGRectGetHeight(frame)-20)/2,100, 20);
    parameterLabel.text = data[@"parameter"];
    parameterLabel.textColor = (index==0?kALL_COLOR:kFontColor_Contacts);
    parameterLabel.font = [UIFont fontWithName:kFontName size:12];
    [view addSubview:parameterLabel];
    
    return view;
}

- (void)tapClicked{
    
    CGRect tRect = expandView.frame;
    CGRect bRect = footerView.frame;
    
    if (!expandFlag) {
        tRect.size.height = expandArray.count*40;
        bRect.origin.y += expandArray.count*40;
    }else{
        
        tRect.size.height = 0;
        bRect.origin.y -= expandArray.count*40;
    }
    
     expandFlag = !expandFlag;
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(bRect)+5);
    
    [UIView animateWithDuration:.3 animations:^{
        expandView.frame = tRect;
        footerView.frame = bRect;
    } completion:^(BOOL finished) {
      [expandView setHidden:!expandFlag];
      expandView.alpha = expandFlag?1.0:0.0;
        UILabel *label = [self.scrollView viewWithTag:3000];
        label.text = expandFlag?@"收缩显示":@"展开更多";
    }];
    
}




@end
