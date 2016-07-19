//
//  OfficeViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "OfficeViewController.h"
#import "UIView+BindValues.h"

@interface OfficeViewController (){
    NSDictionary *officeInfos;
    
    CGFloat _width;
    CGFloat height;
    NSInteger col;
}

@end

@implementation OfficeViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    height = 45.0;//高度
    col = 3;//列数
    
    [self initThisView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    
    NSArray *array = @[@"心脏内科",@"风湿免疫科",@"神经内科",@"转染病中心",@"消化内科",@"内分泌科"];
    NSArray *array1 = @[@"神经外科",@"胸外科",@"血管外科",@"转染外壳",@"分泌外科",@"阿斯顿发生"];
    officeInfos = @{@"内科":array,@"外科":array1};
    int i = 0;
    CGRect frame = CGRectMake(0,0,self.viewWidth,0);
    for (NSString *group in officeInfos.allKeys) {
        UIView *groupView = [self drawGroupViewWithFrame:frame group:group];
        [self.scrollView addSubview:groupView];
        frame = groupView.frame;
        if (i < officeInfos.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame),self.viewWidth,0);
        }
        i++;
    }
}

- (UIView *)drawGroupViewWithFrame:(CGRect)frame group:(NSString *)group{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    view.value = group;
    
    UILabel *groupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth, 40)];
    groupLabel.text = [NSString stringWithFormat:@"   %@",group];
    groupLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [view addSubview:groupLabel];
    
    UIView *childView = [self drawChildViewWithGroup:group];
    [view addSubview:childView];
    CGRect tFrame = childView.frame;
    tFrame.origin.y = CGRectGetMaxY(groupLabel.frame);
    childView.frame = tFrame;
    
    frame.size.height = CGRectGetHeight(groupLabel.frame) + CGRectGetHeight(childView.frame);
    view.frame = frame;

    return view;
}

- (UIView *)drawChildViewWithGroup:(NSString *)group{
    
    NSArray *arr = officeInfos[group];
    
    NSInteger row = ceil(arr.count/3.0);
    CGFloat width = (self.viewWidth - 30) / 3.0;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.viewWidth, 10+row*height+15)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    NSInteger i=0;
    NSInteger k=0;
    for ( NSInteger j = 0;j < arr.count;j++){
        NSString *title =  arr[j];
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

- (void)buttonAction:(UIButton *)sender{
    NSLog(@"value:%@ id:%@",sender.value,sender.Id);
    if (self.style == OfficeStyleChoose) {
        self.block(sender.Id);
    }
    
    [self backAction];
}

- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block{
    self.block = block;
}


@end
