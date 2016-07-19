//
//  RegisterRemindViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "RegisterRemindViewController.h"
#import "WaitingDoctorViewController.h"

@interface RegisterRemindViewController (){
    NSArray *valueArray;
}

@end

@implementation RegisterRemindViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
      valueArray = @[@{@"title":@"2016-06-21",@"remind":@"你已经成功预约",@"dept":@"心血管外科",@"doctor":@"郭应强 主任医师",@"time":@"2016-06-21 周二 下午"},@{@"title":@"2016-06-20",@"remind":@"你已经成功预约",@"dept":@"内科",@"doctor":@"问天赋 主任医师",@"time":@"2016-06-20 周一 下午"}];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    
  
    
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 135);
    int h = 0;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSDictionary *data = valueArray[i];
        UIView *testView = [self drawListView:frame data:data  action:@selector(listDataClicked:) tag:i];
        [self.scrollView addSubview:testView];
        if (i < valueArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 135);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (UIView *)drawListView:(CGRect)frame data:(NSDictionary *)data action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth, 40)];
    titleLabel.text = [NSString stringWithFormat:@"   %@",data[@"title"]];
    titleLabel.font = [UIFont fontWithName:kFontName size:14.0];
    titleLabel.backgroundColor = kBackgroundColor;
    [view addSubview:titleLabel];
    
    UILabel *remindlabel = [UILabel new];
    remindlabel.frame = CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth, 20);
    [view addSubview:remindlabel];
    remindlabel.font = [UIFont fontWithName:kFontName size:14.0];
    remindlabel.text  = [NSString stringWithFormat:@"%@",data[@"remind"]];
  
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(20,CGRectGetMaxY(remindlabel.frame)+2,self.viewWidth-40, 1);
    line.backgroundColor = kBackgroundColor;
    [view addSubview:line];
    
    
    UILabel *label1 = [UILabel new];
    label1.frame = CGRectMake(0,CGRectGetMaxY(line.frame)+2,self.viewWidth, 20);
    label1.text = [NSString stringWithFormat:@"   科       室  %@",data[@"dept"]];
    label1.textColor = kFontColor;
    label1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label1];
    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(0,CGRectGetMaxY(label1.frame)+2,self.viewWidth, 20);
    label2.text = [NSString stringWithFormat:@"   医       生  %@",data[@"doctor"]];
    label2.textColor = kFontColor;
    label2.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label2];
    
    
    UILabel *label3 = [UILabel new];
    label3.frame = CGRectMake(0,CGRectGetMaxY(label2.frame)+2,self.viewWidth, 20);
    label3.text = [NSString stringWithFormat:@"   就诊时间  %@",data[@"time"]];
    label3.textColor = kFontColor;
    label3.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label3];
    
    
    UIImageView *jtImageView = [UIImageView new];
    jtImageView.frame = CGRectMake(self.viewWidth-40, (CGRectGetHeight(frame)-30)/2+15,30, 30);
    jtImageView.image = [UIImage imageNamed:@"箭头"];
    [view addSubview:jtImageView];
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}

- (void)listDataClicked:(UITapGestureRecognizer *)sender{
    
    WaitingDoctorViewController *waitingDoctorViewController = WaitingDoctorViewController.new;
    waitingDoctorViewController.title = @"预约提醒";
    [self.navigationController pushViewController:waitingDoctorViewController animated:YES];
    
}



@end
