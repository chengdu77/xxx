//
//  MyNewsViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MyNewsViewController.h"
#import "UIView+BindValues.h"
#import "MedicalRecordViewController.h"
#import "RegisterRemindViewController.h"
#import "InspectionReportRemindViewController.h"

@interface MyNewsViewController (){
    NSArray *imageArray;
    NSArray *valueArray;
}

@end

@implementation MyNewsViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    UIImage *case_history_remind = [UIImage imageNamed:@"case_history_remind"];
    UIImage *registration_remind = [UIImage imageNamed:@"registration_remind"];
    UIImage *examine_report_remind = [UIImage imageNamed:@"examine_report_remind"];
    imageArray = @[case_history_remind,registration_remind,examine_report_remind];
    valueArray = @[@{@"title":@"病历提醒",@"detail":@"就医结束了，赶紧完善你的病历吧"},@{@"title":@"预约挂号提醒",@"detail":@"就医结束了，赶紧完善你的病历吧"},@{@"title":@"检查报告提醒",@"detail":@"就医结束了，赶紧完善你的病历吧"}];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    int h = 5;//控制行间距
    CGRect frame = CGRectMake(0,5,self.viewWidth, 60);
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSDictionary *data = valueArray[i];
        UIView *testView = [self drawListView:frame data:data image:imageArray[i] action:@selector(listDataClicked:) tag:i];
        [self.scrollView addSubview:testView];
        if (i < valueArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 60);
        }
    }
    
     self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (UIView *)drawListView:(CGRect)frame data:(NSDictionary *)data image:(UIImage *)image action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    view.value = data[@"title"];
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(15, (CGRectGetHeight(frame)-30)/2,30,30);
    imageView.image = image;
    [view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+5, 10,self.viewWidth, 20);
    label.text = data[@"title"];
    label.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label];
    
    UILabel *detail = [UILabel new];
    detail.frame = CGRectMake(CGRectGetMaxX(imageView.frame)+5,CGRectGetMaxY(label.frame)+1,self.viewWidth, 20);
    detail.text = data[@"detail"];
    detail.textColor = kFontColor;
    detail.font = [UIFont fontWithName:kFontName size:12];
    detail.numberOfLines = 0;
    [view addSubview:detail];
    
//    UIImageView *jtImageView = [UIImageView new];
//    jtImageView.frame = CGRectMake(self.viewWidth-40, (CGRectGetHeight(frame)-30)/2,30, 30);
//    jtImageView.image = [UIImage imageNamed:@"箭头"];
//    [view addSubview:jtImageView];
    
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
            tempVC = MedicalRecordViewController.new;
            break;
        case 1:
            tempVC = RegisterRemindViewController.new;
            break;
        case 2:
            tempVC = InspectionReportRemindViewController.new;
            break;
    }
    tempVC.title = title;
    [self.navigationController pushViewController:tempVC animated:YES];
    
}




@end
