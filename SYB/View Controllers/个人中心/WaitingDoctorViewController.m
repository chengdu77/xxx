//
//  WaitingDoctorViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "WaitingDoctorViewController.h"

@interface WaitingDoctorViewController ()

@end

@implementation WaitingDoctorViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(10,0,self.viewWidth-10, 40);
    
    NSString *state = @"订单状态 待就诊";
    NSRange r = [state rangeOfString:@" "];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:state];
    [str addAttribute:NSForegroundColorAttributeName value:RGB(244, 166, 146) range:NSMakeRange(r.location,str.length-r.location)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(r.location,str.length -r.location)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(0,r.location)];
    
    UILabel *stateLabel = [[UILabel alloc] initWithFrame:frame];
    stateLabel.attributedText = str;
    [self.scrollView addSubview:stateLabel];
    
    NSArray *valueArray = @[
  @{@"title":@"就诊日期",@"value":@"2016-06-21"},
  @{@"title":@"取号地点",@"value":@"1楼门诊挂号收费处"},
  @{@"title":@"就诊地点",@"value":@"5楼耳鼻喉科"},
  @{@"title":@"就诊医院",@"value":@"成都华西医院"},
  @{@"title":@"科室医生",@"value":@"神经内科 郭应强"},
  @{@"title":@"门诊时段",@"value":@"2016-06-21 周二 下午"},
  @{@"title":@"挂   号",@"value":@"35"},
  @{@"title":@"挂号费用",@"value":@"11.00元"},
  @{@"title":@"患者姓名",@"value":@"韩梅梅"},
  @{@"title":@"身份证号",@"value":@"5101**********4107"},
  @{@"title":@"手机号",@"value":@"153****1278"}
  ];
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth,40);
    int h = 1;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSDictionary *data = valueArray[i];
        UIView *testView = [self addViewWithFrame:frame data:data];
        [self.scrollView addSubview:testView];
        if (i==2 || i==7){
            h = 5;
        }else{
            h = 1;
        }
        if (i < valueArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 40);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame));
}

- (UIView *)addViewWithFrame:(CGRect)frame data:(NSDictionary *)data{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, (CGRectGetHeight(frame)-20)/2,60, 20);
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

@end
