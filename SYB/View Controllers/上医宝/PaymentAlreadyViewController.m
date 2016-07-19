//
//  PaymentAlreadyViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/26.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "PaymentAlreadyViewController.h"

@interface PaymentAlreadyViewController (){
    BOOL expandFlag;
    UIView *expandView;
    
    NSArray *headArray;
    NSArray *detailArray;
}

@end

@implementation PaymentAlreadyViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    headArray = @[@{@"title":@"账单总额",@"value":@"145.00元"},
                  @{@"title":@"就 诊 人",@"value":@"韩梅梅"},
                  @{@"title":@"就诊卡号",@"value":@"13697723479"},
                  @{@"title":@"时      间",@"value":@"2014-12-04"},
                  @{@"title":@"支付状态",@"value":@"已支付"}
                  ];
    
    detailArray = @[@{@"title":@"合计：",@"value":@"279.00元"},
                    @{@"title":@"抗病毒冲剂x9",@"value":@"5.00元"},
                    @{@"title":@"抗病毒颗粒x13",@"value":@"15.00元"},
                    @{@"title":@"感冒清x1",@"value":@"35.00元"},
                    @{@"title":@"白加黑x4",@"value":@"1.00元"}
                    ];

    expandFlag = NO;
    [self initThisView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    int h = 1;//控制行间距
    UIColor *textColor = nil;
    for(NSUInteger i = 0;i < headArray.count;i++){
        NSDictionary *data = headArray[i];
        UIView *testView = [self childViewWithFrame:frame data:data textColor1:nil textColor2:textColor flag:NO];
        [self.scrollView addSubview:testView];
        if (i < headArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 40);
        }else{
            textColor = RGB(244, 166, 146);
        }
    }
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth, 40);
    UIView *tView = [[UIView alloc] initWithFrame:frame];
    tView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:tView];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,100,40)];
    descLabel.text = @"费用清单";
    descLabel.textColor = kFontColor_Contacts;
    descLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tView addSubview:descLabel];
    
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewWidth -70,0,60, 40)];
    textLabel.text = @"展开查看";
    textLabel.tag = 3000;
    textLabel.textColor = kALL_COLOR;
    textLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tView addSubview:textLabel];
    
    tView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expandClicked:)];
    [tView addGestureRecognizer:tapGesture];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40*detailArray.count +detailArray.count -1);
    expandView = [[UIView alloc] initWithFrame:frame];
    expandView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:expandView];
    [expandView setHidden:YES];
    
    CGRect tempFrame = CGRectMake(0,0,self.viewWidth, 40);
    UIColor *textColor1 = nil;
    UIColor *textColor2 = RGB(244, 166, 146);
    h = 1;
    for(NSUInteger i = 0;i < detailArray.count;i++){
        NSDictionary *data = detailArray[i];
        UIView *testView = [self childViewWithFrame:tempFrame data:data textColor1:textColor1 textColor2:textColor2 flag:YES];
        [expandView addSubview:testView];
        textColor1 = kFontColor_Contacts;
        textColor2 = kFontColor;
        if (i < detailArray.count-1) {
            
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(i==0?0:10,CGRectGetMaxY(tempFrame),self.viewWidth-(i==0?0:20),1)];
            lineLabel.backgroundColor = kBackgroundColor;
            [expandView addSubview:lineLabel];
            
            tempFrame = CGRectMake(0, CGRectGetMaxY(tempFrame)+h,self.viewWidth, 40);
        }
    }
}

- (UIView *)childViewWithFrame:(CGRect)frame data:(NSDictionary *)data  textColor1:(UIColor *)textColor1 textColor2:(UIColor *)textColor2 flag:(BOOL)flag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, (CGRectGetHeight(frame)-20)/2,flag?120:80, 20);
    titleLabel1.text = data[@"title"];
    titleLabel1.textColor = textColor1?textColor1:kFontColor;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:titleLabel1];
    
    UILabel *valueLabel = [UILabel new];
    valueLabel.frame = CGRectMake(flag?120:80, (CGRectGetHeight(frame)-20)/2,self.viewWidth-(flag?130:90), 20);
    valueLabel.text = data[@"value"];
    valueLabel.textColor = textColor2?textColor2:kFontColor_Contacts;
    valueLabel.font = [UIFont fontWithName:kFontName size:14];
    valueLabel.textAlignment = flag?NSTextAlignmentRight:NSTextAlignmentLeft;
    [view addSubview:valueLabel];
    
    return view;
}

- (void)expandClicked:(UITapGestureRecognizer *)sender{
    
    CGRect tRect = expandView.frame;
    
    if (!expandFlag) {
        tRect.size.height = detailArray.count*40;
//        bRect.origin.y += detailArray.count*40;
    }else{
        
        tRect.size.height = 0;
//        bRect.origin.y -= detailArray.count*40;
    }
    
    expandFlag = !expandFlag;
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(tRect)+5);
    
    [UIView animateWithDuration:.3 animations:^{
        expandView.frame = tRect;
    } completion:^(BOOL finished) {
        [expandView setHidden:!expandFlag];
        expandView.alpha = expandFlag?1.0:0.0;
        UILabel *label = [self.scrollView viewWithTag:3000];
        label.text = expandFlag?@"收缩清单":@"展开查看";
    }];

    
}

@end
