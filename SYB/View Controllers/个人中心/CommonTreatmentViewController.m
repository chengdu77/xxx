//
//  CommonTreatmentViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "CommonTreatmentViewController.h"
#import "ModifyTreatmentViewController.h"
#import "UIView+BindValues.h"

@interface CommonTreatmentViewController (){
    NSMutableArray *personsArray;
}

@end

@implementation CommonTreatmentViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    personsArray = [NSMutableArray arrayWithArray:@[@"李磊",@"韩梅梅"]];
    
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
    zhuLabel.text = @"   主账号";
    zhuLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:zhuLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 85);
    UIView *mainView = [self drawListView:frame title:@"徐小雨" image:nil action:@selector(mainAction:) tag:0];
     [self.scrollView addSubview:mainView];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 40);
    UILabel *treatmentLabel = [[UILabel alloc] initWithFrame:frame];
    treatmentLabel.text = @"   就诊人";
    treatmentLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:treatmentLabel];
    
    NSArray *valuesArray = personsArray;
    int h = 5;//控制行间距
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 85);
    for(NSUInteger i = 0;i < valuesArray.count;i++){
        NSString *title = valuesArray[i];
        UIView *testView = [self drawListView:frame title:title image:nil action:@selector(listDataClicked:) tag:i];
        [self.scrollView addSubview:testView];
        if (i < valuesArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 85);
        }
    }
    
    frame = CGRectMake(10,CGRectGetMaxY(frame)+10,self.viewWidth -20, 40);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = kALL_COLOR;
    [button setTitle:@"新建就诊人" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:button];
    
     self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
    
}

- (UIView *)drawListView:(CGRect)frame title:(NSString *)title image:(UIImage *)image action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    
//    UIImageView *imageView = [UIImageView new];
//    imageView.frame = CGRectMake(15, (56-25)/2,25, 25);
//    imageView.image = image;
//    [view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, 10,self.viewWidth, 20);
    label.text = [NSString stringWithFormat:@"   %@",title];
    label.font = [UIFont fontWithName:kFontName size:16];
    [view addSubview:label];
    
    UILabel *label1 = [UILabel new];
    label1.frame = CGRectMake(0,CGRectGetMaxY(label.frame)+5,self.viewWidth, 20);
    label1.text = [NSString stringWithFormat:@"   身份证号：%@",@"510523198806025236"];
    label1.textColor = kFontColor;
    label1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label1];
    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(0,CGRectGetMaxY(label1.frame)+5,self.viewWidth, 20);
    label2.text = [NSString stringWithFormat:@"   手机号：%@",@"13800013800"];
    label2.textColor = kFontColor;
    label2.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label2];
    
    if (self.style == CommonTreatmentStyleChoose) {
        UIImageView *jtImageView = [UIImageView new];
        jtImageView.frame = CGRectMake(self.viewWidth-40, (CGRectGetHeight(frame)-30)/2,30, 30);
        jtImageView.image = [UIImage imageNamed:@"箭头"];
        [view addSubview:jtImageView];
    }
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}

- (void)mainAction:(UITapGestureRecognizer *)sender{
    NSUInteger tag = sender.view.tag;
    if (self.style == CommonTreatmentStyleChoose) {
        [self backAction];
        self.block(personsArray[tag]);
    }
}

- (void)listDataClicked:(UITapGestureRecognizer *)sender{
    
    NSUInteger tag = sender.view.tag;
    if (self.style == CommonTreatmentStyleChoose) {
        [self backAction];
        self.block(personsArray[tag]);
    }
    
}

- (void)addAction:(UIButton *)sender{
    
    ModifyTreatmentViewController *modifyTreatmentViewController = ModifyTreatmentViewController.new;
    modifyTreatmentViewController.operationMode = TreatmentOperationModeInsert;
    modifyTreatmentViewController.title = @"新建就诊人";
    [modifyTreatmentViewController updateInfo:nil withRefreshSupperView:^(id data) {
        
        [personsArray insertObject:data atIndex:personsArray.count];
        [self initThisView];
        
    }];
    [self.navigationController pushViewController:modifyTreatmentViewController animated:YES];
}

- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block{
    self.block = block;
    
}

@end
