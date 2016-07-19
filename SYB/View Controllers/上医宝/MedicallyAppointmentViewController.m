//
//  MedicallyAppointmentViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/23.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MedicallyAppointmentViewController.h"
#import "UIView+BindValues.h"
#import "MedicallyExpertListViewController.h"

#define kTabViewWidth 80

@interface MedicallyAppointmentViewController (){
    NSArray *tabButtonTitle;
    NSMutableArray *tabButtonArray;
    
    NSArray *childViewArray;

    
    UIScrollView *dataView;
    
    CGRect tabButtonFrame;
}

@end

@implementation MedicallyAppointmentViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    self.title = @"预约挂号";
    
    tabButtonTitle = @[@"内科",@"外科",@"妇女",@"其他"];
    tabButtonArray = [NSMutableArray array];
    
    NSArray *array0 = @[@"心脏内科",@"风湿免疫科",@"神经内科",@"转染病中心",@"消化内科",@"内分泌科"];
    NSArray *array1 = @[@"神经外科1",@"胸外科1",@"血管外科1",@"转染外壳1",@"分泌外科1",@"阿斯顿发生1"];
    NSArray *array2 = @[@"心脏内科2",@"风湿免疫科2",@"神经内科2",@"转染病中心2",@"消化内科2",@"内分泌科2"];
    NSArray *array3 = @[@"神经外科3",@"胸外科3",@"血管外科3",@"转染外壳3",@"分泌外科3",@"阿斯顿发生3"];
    NSArray *array4 = @[@"心脏内科4",@"风湿免疫科4",@"神经内科4",@"转染病中心4",@"消化内科4",@"内分泌科4"];
    childViewArray = @[array0,array1,array2,array3,array4];
    
    [self initTabView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initTabView{
    
    CGRect frame = CGRectMake(kTabViewWidth,0,self.viewWidth-80,self.viewHeight);
    dataView = [[UIScrollView alloc] initWithFrame:frame];
    dataView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:dataView];
    
    CGRect rect = CGRectMake(0,0,kTabViewWidth,40);
    CGFloat h = 1;
    for (int i = 0;i < tabButtonTitle.count;i++){
        NSString *title = tabButtonTitle[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect;
        button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:kALL_COLOR];
        button.tag = i;
        [button addTarget:self action:@selector(tabButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i < tabButtonTitle.count-1) {
            rect.origin.y = CGRectGetMaxY(rect)+h;
        }
        
        [self.scrollView addSubview:button];
        [tabButtonArray addObject:button];
    }
    
    UIButton *button = tabButtonArray[0];
    button.backgroundColor = [UIColor whiteColor];
    
    [self diplayDataViewWithGroup:@"0"];
}

- (void)tabButtonAction:(UIButton *)sender{
    
    for (UIButton *button in tabButtonArray) {
        button.backgroundColor = kALL_COLOR;
    }
    
    sender.backgroundColor = [UIColor whiteColor];
    NSString *group = [NSString stringWithFormat:@"%@",@(sender.tag)];
    
    [self diplayDataViewWithGroup:group];
    
}

- (UIView *)drawChildViewWithGroup:(NSString *)group array:(NSArray *)array{
    
    CGFloat height = 40.0;//高度
    int col = 2;//列数
   
    NSInteger row = ceil(array.count/2.0);
    CGFloat width = (self.viewWidth - kTabViewWidth -20) / 2.0;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.viewWidth -kTabViewWidth, 10+row*height+15)];
    view.backgroundColor = [UIColor whiteColor];
    
    NSInteger i=0;
    NSInteger k=0;
    for ( NSInteger j = 0;j < array.count;j++){
        NSString *title =  array[j];
        i = j % col;
        k = floorl(j / col);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(width+5)+10, 10+k*(height+5), width, height);
        button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kALL_COLOR forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = j;
        button.value = group;
        button.Id = title;
        [view addSubview:button];
        button.layer.borderColor = kALL_COLOR.CGColor;
        button.layer.borderWidth = .5;
        button.layer.cornerRadius = 5;
    }
    
    return view;
    
}

- (void)diplayDataViewWithGroup:(NSString *)group{

    for(UIView *view in dataView.subviews){
        [view removeFromSuperview];
    }
    
    UIView *childView = [self drawChildViewWithGroup:group array:childViewArray[[group integerValue]]];
    [dataView addSubview:childView];
    CGRect tFrame = childView.frame;
    tFrame.size.height +=5;
    [dataView setContentSize:tFrame.size];

}

- (void)buttonAction:(UIButton *)sender{
    
    NSLog(@"sender.Id:%@ group:%@",sender.Id,sender.value);
    MedicallyExpertListViewController *medicallyExpertListViewController = MedicallyExpertListViewController.new;
    medicallyExpertListViewController.title = sender.Id;
    [self.navigationController pushViewController:medicallyExpertListViewController animated:YES];

}

@end
