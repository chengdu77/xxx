//
//  PaymentNotViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/26.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "PaymentNotViewController.h"
#import "AppointmentCell.h"
#import "UIView+BindValues.h"
#import "SendAddressViewController.h"

@interface PaymentNotViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    NSArray *headArray;
    NSArray *detailArray;
    
    UITableView *_tableView;
    CGFloat tableViewHeight;
    
    BOOL expandFlag;
    UIView *expandView;
    UIView *footerView;
    UIImageView *checkboxImageView;
    
    NSMutableArray *checkboxArray;//支付方式数组
    NSMutableArray *_options;//具体几种支付方式数组
}

@end

@implementation PaymentNotViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    headArray = @[@{@"title":@"账单总额",@"value":@"35.00元"},
                  @{@"title":@"就 诊 人",@"value":@"韩梅梅"},
                  @{@"title":@"就诊卡号",@"value":@"13697723479"},
                  @{@"title":@"时      间",@"value":@"2014-12-04"},
                  @{@"title":@"支付状态",@"value":@"未支付"}
                  ];
    detailArray = @[@{@"title":@"合计：",@"value":@"279.00元"},
                    @{@"title":@"抗病毒冲剂x9",@"value":@"5.00元"},
                    @{@"title":@"抗病毒颗粒x13",@"value":@"15.00元"},
                    @{@"title":@"感冒清x1",@"value":@"35.00元"},
                    @{@"title":@"白加黑x4",@"value":@"1.00元"}
                    ];
    
    expandFlag = NO;
    
    checkboxArray = [NSMutableArray array];
    _options = [NSMutableArray array];
 
    UIImage *image = [UIImage imageNamed:@"zhifubao"];
    NSString *pmName = @"支付宝支付";
    NSString *detail = @"推荐已安装支付宝客户端的用户使用";
    BOOL flag = YES;
    NSDictionary *info = @{@"image":image,@"pmName":pmName,@"detail":detail,@"flag":@(flag)};
    [_options addObject:info];
    
    image = [UIImage imageNamed:@"weixin"];
    pmName = @"微信支付";
    detail = @"推荐已安装微信5.0版本客户端的用户使用";
    flag = NO;
    info = @{@"image":image,@"pmName":pmName,@"detail":detail,@"flag":@(flag)};
    [_options addObject:info];
    
    image = [UIImage imageNamed:@"unionpay"];
    pmName = @"银联支付";
    detail = @"推荐银联卡持有人使用";
    flag = NO;
    info = @{@"image":image,@"pmName":pmName,@"detail":detail,@"flag":@(flag)};
    [_options addObject:info];
    
    image = [UIImage imageNamed:@"medicarecards"];
    pmName = @"医保卡支付";
    detail = @"推荐医保卡持有人使用";
    flag = NO;
    info = @{@"image":image,@"pmName":pmName,@"detail":detail,@"flag":@(flag)};
    [_options addObject:info];
    
    image = [UIImage imageNamed:@"socialcards"];
    pmName = @"新型农村合作医疗证支付";
    detail = @"推荐农村社保卡持有人使用";
    flag = NO;
    info = @{@"image":image,@"pmName":pmName,@"detail":detail,@"flag":@(flag)};
    [_options addObject:info];
    
    tableViewHeight = _options.count *60;
    
    [self initThisView];
    
    if (checkboxArray.count > 0) {
        UIImageView *imageView0 = checkboxArray[0];
        UIImageView *imageView1 = checkboxArray[1];
        
        imageView0.image = [UIImage imageNamed:@"checkbox_select"];
        imageView1.image = [UIImage imageNamed:@"checkbox_not_select"];
    }

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
    descLabel.text = @"选择支付方式";
    descLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tView addSubview:descLabel];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(frame), self.viewWidth,tableViewHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.scrollView addSubview:_tableView];
    _tableView.backgroundColor = kBackgroundColor;
    UINib *nib=[UINib nibWithNibName:@"AppointmentCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"AppointmentCell"];
    [_tableView reloadData];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    frame = _tableView.frame;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth, 40);
    UIView *tempView = [[UIView alloc] initWithFrame:frame];
    tempView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:tempView];
    
    UILabel *costListLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,100,40)];
    costListLabel.text = @"费用清单";
    costListLabel.textColor = kFontColor_Contacts;
    costListLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tempView addSubview:costListLabel];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewWidth -70,0,60, 40)];
    textLabel.text = @"展开查看";
    textLabel.tag = 3000;
    textLabel.textColor = kALL_COLOR;
    textLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tempView addSubview:textLabel];
    
    tempView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expandClicked:)];
    [tempView addGestureRecognizer:tapGesture];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth,0);
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
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth, 105);
    footerView = [[UIView alloc] initWithFrame:frame];
    tempView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:footerView];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,60)];
    tmpView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:tmpView];
    
    tmpView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tmpTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendClicked:)];
    [tmpView addGestureRecognizer:tmpTapGesture];

    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,15,160,20)];
    tempLabel.text = @"是否需要送药上门";
    tempLabel.textColor = kFontColor_Contacts;
    tempLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tmpView addSubview:tempLabel];
    
    checkboxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewWidth -30,15,20,20)];
    checkboxImageView.image = [UIImage imageNamed:@"checkbox_not_select"];
    checkboxImageView.type = @(NO);
    [tmpView addSubview:checkboxImageView];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//button的类型
    button.frame = CGRectMake(10,CGRectGetMaxY(tmpView.frame)+5,self.viewWidth -20,40);
    button.backgroundColor = kALL_COLOR;
    [button setTitle:@"确认支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [button addTarget:self action:@selector(paymentAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];

    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _options.count;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tableViewIdentifier = @"AppointmentCell";
    
    AppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (cell == nil) {
        cell = [[AppointmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIdentifier];
    }
    
    NSDictionary *data = _options[indexPath.row];
    
    cell.photoImageView.image = data[@"image"];
    
    cell.titleLabel.text = data[@"pmName"];
    cell.titleLabel.font = [UIFont fontWithName:kFontName size:14.0];
    cell.createdateLabel.text = data[@"detail"];
    cell.createdateLabel.font = [UIFont fontWithName:kFontName size:12.0];
    cell.createdateLabel.textColor = kFontColor;
    BOOL flag = [data[@"flag"] boolValue];
    cell.flagImageView.image = flag?[UIImage imageNamed:@"item_registration_select"]:[UIImage imageNamed:@"checkbox_not_select"];
    
    cell.backgroundColor = ((indexPath.row+1)%2 == 1)?RGB(245, 248, 253):[UIColor whiteColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = _options[indexPath.row];
    NSString *pmName = data[@"pmName"];
    BOOL flag = [data[@"flag"] boolValue];
    if (flag) {
        return;
    }
    for(int i = 0;i<_options.count;i++){
        NSDictionary *info = _options[i];
        
        UIImage *image = info[@"image"];
        NSString *pmName_ = info[@"pmName"];
        NSString *detail = info[@"detail"];
        
        if ([info[@"pmName"] isEqualToString:pmName]) {
            flag = YES;
        }else{
            flag = NO;
        }
        NSDictionary *newDic = @{@"image":image,@"pmName":pmName_,@"detail":detail,@"flag":@(flag)};
        
        [_options replaceObjectAtIndex:i withObject:newDic];
    }
    
    [tableView reloadData];
    
}

- (void)expandClicked:(UITapGestureRecognizer *)sender{
    
    CGRect tRect = expandView.frame;
    CGRect bRect = footerView.frame;
    
    CGFloat height = 40*detailArray.count +detailArray.count -1;
    
    if (!expandFlag) {
        tRect.size.height = height;
        bRect.origin.y += height;
    }else{
        tRect.size.height = 0;
        bRect.origin.y -= height;
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
        label.text = expandFlag?@"收缩清单":@"展开查看";
    }];
    
}

- (void)sendClicked:(UITapGestureRecognizer *)sender{
    
    BOOL flag = [checkboxImageView.type boolValue];
    if (!flag) {
        checkboxImageView.image = [UIImage imageNamed:@"checkbox_select"];
        SendAddressViewController *sendAddressViewController = SendAddressViewController.new;
        NSRange range = NSMakeRange(1,detailArray.count-1);
        NSArray *array = [detailArray subarrayWithRange:range];
        sendAddressViewController.detailArray = array;
        [self.navigationController pushViewController:sendAddressViewController animated:YES];
    }else{
        checkboxImageView.image = [UIImage imageNamed:@"checkbox_not_select"];
    }
    
    checkboxImageView.type = @(!flag);
    
}

- (void)paymentAction:(UIButton *)sender{
    
}



@end
