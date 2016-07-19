//
//  ContackViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ContackViewController.h"
#import "UIView+BindValues.h"
#import "PullingRefreshTableView.h"

@interface ContackViewController (){
    PullingRefreshTableView *_tableView;
    
    NSMutableArray *tempArray;
    NSInteger pageNumber;
}

@end

@implementation ContackViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:frame];
    phoneLabel.text = @"   急救电话";
    phoneLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:phoneLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 56);
    NSArray *arr = @[@"028-54652855",@"028-54652184",@"028-54651849"];
    
    for (int i=0;i<arr.count;i++) {
        NSString *title = arr[i];
        UIView *view = [self addButtonWithFrame:frame title:title];
        [self.scrollView addSubview:view];
        if (i< arr.count -1) {
            frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 56);
        }
    }
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 40);
    UILabel *queryLabel = [[UILabel alloc] initWithFrame:frame];
    queryLabel.text = @"   查询电话";
    queryLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:queryLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 56);
    UIView *view = [self addButtonWithFrame:frame title:@"028-54651849"];
    [self.scrollView addSubview:view];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+10,self.viewWidth, 20);
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:frame];
    emailLabel.text = @"   医院纪委意见电子信箱：wjcmail@qq.com";
    emailLabel.font = [UIFont fontWithName:kFontName size:14.0];
    emailLabel.textColor = kFontColor;
    [self.scrollView addSubview:emailLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 20);
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:frame];
    tempLabel.text = @"   邮编：610000";
    tempLabel.font = [UIFont fontWithName:kFontName size:14.0];
    tempLabel.textColor = kFontColor;
    [self.scrollView addSubview:tempLabel];
}

- (UIView *)addButtonWithFrame:(CGRect)frame title:(NSString *)title{
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
    button.frame = CGRectMake(10,(CGRectGetHeight(frame) -40)/2,CGRectGetWidth(frame) -20,40);
    button.backgroundColor = kALL_COLOR;
    
    UIImage *image = [UIImage imageNamed:@"phone"];
    image = [self imageByScalingAndCroppingForSourceImage:image targetSize:CGSizeMake(20,20)];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
//    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleEdgeInsets = UIEdgeInsetsMake(0,-20,0,20);//设置title在button上的位置（上top，左left，下bottom，右right）
    //在UIButton中有三个对EdgeInsets的设置：ContentEdgeInsets、titleEdgeInsets、imageEdgeInsets
    
    [button setImage:image forState:UIControlStateNormal];//给button添加image
    button.imageEdgeInsets = UIEdgeInsetsMake(0,button.titleEdgeInsets.left-20,0,-button.titleEdgeInsets.right+30);//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:button];
    
    return view;
}

- (void)buttonAction:(UIButton *)sender{
    
    NSString *urlLink = [NSString stringWithFormat:@"tel://%@",sender.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlLink]];
    
}

//self.oneButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
//self.oneButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);

@end
