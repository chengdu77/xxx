//
//  AddCaseHistoryViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "AddCaseHistoryViewController.h"
#import "UIView+BindValues.h"
#import "CommonTreatmentViewController.h"
#import "WHUCalendarPopView.h"
#import "OfficeViewController.h"
#import "ExpertViewController.h"
#import "IQTextView.h"
#import "NextCaseHistoryViewController.h"
#import "UIView+BindValues.h"

@interface AddCaseHistoryViewController (){
    
    NSMutableArray *textFieldArray;
    WHUCalendarPopView *calendarPopView;
    
    UIView *firstView;
    UIView *nextView;
    
    BOOL isNextPage;
    
    IQTextView *textView;
}

@end

@implementation AddCaseHistoryViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    self.title = @"新建病历";
    
    isNextPage = NO;
    
    textFieldArray = [NSMutableArray array];
    calendarPopView = [[WHUCalendarPopView alloc] init];
    
    CGRect frame = self.scrollView.bounds;
    firstView = [[UIView alloc] initWithFrame:frame];
    firstView.backgroundColor = [UIColor clearColor];
    
//    frame.origin.y = CGRectGetMaxY(frame);
//    nextView = [[UIView alloc] initWithFrame:frame];
//    nextView.backgroundColor = [UIColor clearColor];
    
    [self.scrollView addSubview:firstView];
//    [self.scrollView addSubview:nextView];
    
    [self initFirstView];
    [self initNextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)initFirstView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UILabel *detialAddrLabel = [[UILabel alloc] initWithFrame:frame];
    detialAddrLabel.text = @"   填写挂号信息";
    detialAddrLabel.textColor = kFontColor_Contacts;
    detialAddrLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [firstView addSubview:detialAddrLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 56);
    NSArray *valueArray = @[@"就 诊 人",@"就诊时间",@"科       室",@"医       生"];
    UITextField *textField = nil;
    int h = 1;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSString *title = valueArray[i];
        UIView *testView = [self drawViewWithFrame:frame title:title textField:&textField read:YES must:YES tag:i];
        [self.scrollView addSubview:testView];
        [textFieldArray addObject:textField];
        if (i < valueArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 56);
        }
    }
    
    frame = CGRectMake(10,CGRectGetMaxY(frame)+50,self.viewWidth -20,40);
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = frame;
    nextButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    nextButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundColor:kALL_COLOR];
    [nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:nextButton];
}

- (void)initNextView{
    
//    CGRect frame = CGRectMake(0,64,self.viewWidth, 40);
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
//    titleLabel.text = @"   完善病历信息";
//    titleLabel.font = [UIFont fontWithName:kFontName size:16.0];
//    [nextView addSubview:titleLabel];
//    
//    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth,230);
//    UIView *doctorView = [UIView new];
//    doctorView.backgroundColor = [UIColor whiteColor];
//    doctorView.frame = frame;
//    [nextView addSubview:doctorView];
//    
//    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,40)];
//    tempLabel.text = @"   医嘱";
//    tempLabel.font = [UIFont fontWithName:kFontName size:14.0];
//    [doctorView addSubview:tempLabel];
//    
//    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(tempLabel.frame),self.viewWidth-20,1)];
//    lineLabel.backgroundColor = kBackgroundColor;
//    [doctorView addSubview:lineLabel];
//    
//    textView = [[IQTextView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(lineLabel.frame),self.viewWidth-20,179)];
//    textView.placeholder = @"医生诊断，如疾病名称等，必填";
//    [doctorView addSubview:textView];
//    
//    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth,160);
    
}

- (UIView *)drawViewWithFrame:(CGRect)frame title:(NSString *)title textField:(UITextField **)textField read:(BOOL)read must:(BOOL)must tag:(NSInteger)tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(15,(CGRectGetHeight(frame) -20)/2,60, 20);
    titleLabel.text = title;
    titleLabel.textColor = kFontColor_Contacts;
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:titleLabel];
    
    UITextField *valueTextField= [UITextField new];
    valueTextField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+2,(CGRectGetHeight(frame) -20)/2,self.viewWidth-135, 20);
    valueTextField.textColor = kFontColor_Contacts;
    valueTextField.font = [UIFont fontWithName:kFontName size:14];
    valueTextField.userInteractionEnabled = !read;
    NSString *placeholder = read?@"点击":@"输入";
    NSString *str = [self removeIntermediateSpace:title];
  
    valueTextField.placeholder = [NSString stringWithFormat:@"请%@%@",placeholder,str];
    [view addSubview:valueTextField];
    
    valueTextField.value = str;
    valueTextField.must = @(must);
    valueTextField.type = @(read);
    
    *textField = valueTextField;

    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewAction:)];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}

- (void)viewAction:(UITapGestureRecognizer *)sender{
    
    NSInteger tag = sender.view.tag;
    __block UITextField *textField = textFieldArray[tag];
    switch (tag) {
        case 0:{
            
            CommonTreatmentViewController *commonTreatmentViewController = CommonTreatmentViewController.new;
            commonTreatmentViewController.title = @"常用就诊人";
            commonTreatmentViewController.myInfo = self.myInfo;
            commonTreatmentViewController.style = CommonTreatmentStyleChoose;
            [commonTreatmentViewController sendInfo:nil withRefreshSupperView:^(id data) {
                textField.text = data[@"realname"];
                textField.value = data[@"id"];
            }];
            [self.navigationController pushViewController:commonTreatmentViewController animated:YES];
            break;
        }
        case 1:{
            
            calendarPopView.onDateSelectBlk=^(NSDate* date){
                NSDate *today = [NSDate date];
                if ([date compare:today] == NSOrderedAscending){
                    [MBProgressHUD showError:@"请有效就诊时间!" toView:ShareAppDelegate.window];
                    return;
                }
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"yyyy-MM-dd"];
                NSString *dateString = [format stringFromDate:date];
                textField.text = dateString;
            };
            [calendarPopView show];
            break;
        }
        case 2:{
            OfficeViewController *officeViewController = OfficeViewController.new;
            officeViewController.title = @"选择科室";
            officeViewController.style = OfficeStyleChoose;
            [officeViewController sendInfo:nil withRefreshSupperView:^(id data) {
                textField.text = data;
            }];
            [self.navigationController pushViewController:officeViewController animated:YES];
            
            break;
        }
        case 3:{
            
            ExpertViewController *expertViewController = ExpertViewController.new;
            expertViewController.title = @"选择专家";
            expertViewController.style = ExpertStyleChoose;
            [expertViewController sendInfo:nil withRefreshSupperView:^(id data) {
                textField.text = data;
        
            }];
            [self.navigationController pushViewController:expertViewController animated:YES];
            
            break;
        }
    }
}

- (void)nextAction:(UIButton *)sender{
    
//    CGPoint point = CGPointZero;
//    point.y = CGRectGetHeight(self.scrollView.bounds);
//    [self.scrollView setContentOffset:point animated:YES];
//    
//    isNextPage = YES;
    
    NSString *p_user_id = [(UITextField *)textFieldArray[0] value];
    if (p_user_id.length ==0) {
        [MBProgressHUD showError:@"请选择就诊人" toView:ShareAppDelegate.window];
        return;
    }
    NSString *visit_time = [(UITextField *)textFieldArray[1] text];
    if (visit_time.length ==0) {
        [MBProgressHUD showError:@"请选择就诊时间" toView:ShareAppDelegate.window];
        return;
    }
    
    NSString *h_office_name =  [(UITextField *)textFieldArray[2] text];
    if (h_office_name.length ==0) {
        [MBProgressHUD showError:@"请选择科室" toView:ShareAppDelegate.window];
        return;
    }
    NSString *s_user_name =  [(UITextField *)textFieldArray[3] text];
    if (s_user_name.length ==0) {
        [MBProgressHUD showError:@"请选择医生" toView:ShareAppDelegate.window];
        return;
    }
    
    NextCaseHistoryViewController *nextCaseHistoryViewController = NextCaseHistoryViewController.new;
    [nextCaseHistoryViewController sendInfo:@{@"p_user_id":p_user_id,@"visit_time":visit_time,@"h_office_name":h_office_name,@"s_user_name":s_user_name} withRefreshSupperView:^(id data) {
        [self backAction];
    }];
    [self.navigationController pushViewController:nextCaseHistoryViewController animated:YES];
}





@end
