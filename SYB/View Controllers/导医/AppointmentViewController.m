//
//  AppointmentViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/16.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "AppointmentViewController.h"
#import "UIView+BindValues.h"
#import "AppointmentCell.h"
#import "ModifyTreatmentViewController.h"

@interface AppointmentViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UITableView *_tableView;
    BOOL tableViewHideFlag;
    
    CGFloat tableViewHeight;
    CGFloat _width;
    CGFloat height;
    NSInteger col;
    
    NSMutableArray *personsArray;//诊断人数组
    NSMutableArray *buttonsArray;//显示是否选中诊断人按钮数组
    NSMutableArray *checkboxArray;//支付方式数组
    NSMutableArray *_options;//具体几种支付方式数组
    

    UIButton *commitButton;
}

@end

@implementation AppointmentViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    height = 30.0;//高度
    col = 3;//列数
    tableViewHideFlag = YES;
    
    buttonsArray = [NSMutableArray array];
    checkboxArray = [NSMutableArray array];
    _options = [NSMutableArray array];
    personsArray = [NSMutableArray array];
    [personsArray addObjectsFromArray:@[@"徐小雨",@"韩梅梅",@"李磊",@"张明",@"秦梦艺",@"＋新建"]];
    
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 115);
    UIView *reservationInforView = [self reservationInforViewWithFrame:frame];
    [self.scrollView addSubview:reservationInforView];
    frame = reservationInforView.frame;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth,0);
    UIView *tpView = [self treatmentPersonsViewWithFrame:frame persons:personsArray];
    [self.scrollView addSubview:tpView];
    frame = tpView.frame;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth,109);
    UIView *tiView = [self treatmentInfoViewWithFrame:frame];
    [self.scrollView addSubview:tiView];
    frame = tiView.frame;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth,85);
    UIView *pmView = [self paymentMethodViewWithFrame:frame];
    [self.scrollView addSubview:pmView];
    frame = pmView.frame;

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(frame), self.viewWidth,tableViewHeight)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.scrollView addSubview:_tableView];
    _tableView.backgroundColor = kBackgroundColor;
    UINib *nib=[UINib nibWithNibName:@"AppointmentCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"AppointmentCell"];
    [_tableView reloadData];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView setHidden:tableViewHideFlag];
    if (!tableViewHideFlag) {
        frame = _tableView.frame;
        
        if (checkboxArray.count > 0) {
            UIImageView *imageView0 = checkboxArray[0];
             UIImageView *imageView1 = checkboxArray[1];
            
            imageView0.image = [UIImage imageNamed:@"checkbox_select"];
            imageView1.image = [UIImage imageNamed:@"checkbox_not_select"];
        }
    }
    
    commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(10,CGRectGetMaxY(frame)+10,self.viewWidth -20, 40);
    commitButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    commitButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton setBackgroundColor:kALL_COLOR];
    [commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:commitButton];

    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
    
}

#pragma mark 预约信息View
- (UIView *)reservationInforViewWithFrame:(CGRect)frame{
    
    CGRect rect = CGRectMake(0,0,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,17,8,8)];
    dotImageView.image = [UIImage imageNamed:@"reg_circle"];
    [view addSubview:dotImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,10,150,20)];
    titleLabel.text = @"您预约的就诊信息";
    titleLabel.font = [UIFont fontWithName:kFontName size:16];
    titleLabel.textColor = kFontColor_Contacts;
    [view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth-20,1)];
    lineView.backgroundColor = kBackgroundColor;
    [view addSubview:lineView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,CGRectGetMaxY(lineView.frame)+5,280,20)];
    nameLabel.text = @"四川省人民医院（内科）郭应强 主任医师";
    nameLabel.font = [UIFont fontWithName:kFontName size:14];
    nameLabel.textColor = kFontColor_Contacts;
    [view addSubview:nameLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,CGRectGetMaxY(nameLabel.frame)+5,280,20)];
    timeLabel.text = @"就诊时间：2016-06-16";
    timeLabel.font = [UIFont fontWithName:kFontName size:14];
    timeLabel.textColor = kFontColor_Contacts;
    [view addSubview:timeLabel];
    
    
    UILabel *costLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(timeLabel.frame)+5,self.viewWidth-20,20)];
    costLabel.text = @"费用：15.00元";
    costLabel.font = [UIFont fontWithName:kFontName size:14];
    costLabel.textColor = RGB(244, 166, 146);
    costLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:costLabel];
    
    return view;
}

//

#pragma mark 确认就诊人View
- (UIView *)treatmentPersonsViewWithFrame:(CGRect)frame persons:(NSArray *)persons{
    
    CGRect rect = CGRectMake(0,frame.origin.y,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,17,8,8)];
    dotImageView.image = [UIImage imageNamed:@"reg_circle"];
    [view addSubview:dotImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,10,150,20)];
    titleLabel.text = @"确认就诊人";
    titleLabel.font = [UIFont fontWithName:kFontName size:16];
    titleLabel.textColor = kFontColor_Contacts;
    [view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth-20,1)];
    lineView.backgroundColor = kBackgroundColor;
    [view addSubview:lineView];
    
    UIView *childView = [self drawPersons:persons];
    CGRect r = childView.frame;
    r.origin.y = CGRectGetMaxY(lineView.frame)+5;
    childView.frame = r;
    [view addSubview:childView];
    
    rect.size.height = 40 + CGRectGetHeight(r);
    view.frame = rect;
    
    return view;
}

- (UIView *)drawPersons:(NSArray *)persons{
    
    NSArray *arr = persons;
    
    NSInteger row = ceil(arr.count/3.0);
    CGFloat width = (self.viewWidth - 30) / 3.0;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.viewWidth, 10+row*height+15)];
    view.backgroundColor = [UIColor whiteColor];
    
    [buttonsArray removeAllObjects];
    
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
//        button.value = group;
        button.Id = title;
        [view addSubview:button];
        button.layer.borderColor = kALL_COLOR.CGColor;
        button.layer.borderWidth = .5;
        button.layer.cornerRadius = 5;
        
        if (j < arr.count -1 ) {
            [buttonsArray addObject:button];
        }
    }
    
    return view;
    
}

#pragma mark 点击就诊人按钮
- (void)buttonAction:(UIButton *)sender{
    
    for(UIButton *button in buttonsArray){
        if (![button isEqual:sender]) {
            [button setTitleColor:kALL_COLOR forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            button.layer.borderColor = kALL_COLOR.CGColor;
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:RGB(244, 166, 146)];
            button.layer.borderColor = RGB(244, 166, 146).CGColor;
        }
    }
    
    //点击"＋新建"操作
    if ([buttonsArray indexOfObject:sender] == NSNotFound){
        ModifyTreatmentViewController *modifyTreatmentViewController = ModifyTreatmentViewController.new;
        modifyTreatmentViewController.operationMode = TreatmentOperationModeInsert;
        modifyTreatmentViewController.title = @"新建就诊人";
        [modifyTreatmentViewController updateInfo:nil withRefreshSupperView:^(id data) {
            
            [personsArray insertObject:data atIndex:personsArray.count-1];
            [self initThisView];
            
        }];
        [self.navigationController pushViewController:modifyTreatmentViewController animated:YES];
    }
}


#pragma mark 就诊人信息View
- (UIView *)treatmentInfoViewWithFrame:(CGRect)frame{
    
    CGRect rect = CGRectMake(0,frame.origin.y,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,17,8,8)];
    dotImageView.image = [UIImage imageNamed:@"reg_circle"];
    [view addSubview:dotImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,10,150,20)];
    titleLabel.text = @"就诊人信息";
    titleLabel.font = [UIFont fontWithName:kFontName size:16];
    titleLabel.textColor = kFontColor_Contacts;
    [view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth-20,1)];
    lineView.backgroundColor = kBackgroundColor;
    [view addSubview:lineView];
    
    UILabel *treatmentIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,CGRectGetMaxY(lineView.frame)+5,280,20)];
    treatmentIdLabel.text = @"就诊卡号  998042456666";
    treatmentIdLabel.font = [UIFont fontWithName:kFontName size:14];
    treatmentIdLabel.textColor = kFontColor;
    [view addSubview:treatmentIdLabel];
    
    
    UILabel *medicareIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,CGRectGetMaxY(treatmentIdLabel.frame)+2,280,20)];
    medicareIdLabel.text = @"医保卡号  998042456666";
    medicareIdLabel.font = [UIFont fontWithName:kFontName size:14];
    medicareIdLabel.textColor = kFontColor;
    [view addSubview:medicareIdLabel];
    
    
    UILabel *cardIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,CGRectGetMaxY(medicareIdLabel.frame)+2,280,20)];
    cardIdLabel.text = @"身份证号  998042456666";
    cardIdLabel.font = [UIFont fontWithName:kFontName size:14];
    cardIdLabel.textColor = kFontColor;
    [view addSubview:cardIdLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.viewWidth-80,CGRectGetMaxY(lineView.frame)+5,60, 26);
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [button setTitle:@"修改" forState:UIControlStateNormal];
    [button setTitleColor:kALL_COLOR forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(modifyAction:) forControlEvents:UIControlEventTouchUpInside];
//    button.tag = j;
    //        button.value = group;
//    button.Id = title;
    [view addSubview:button];
    button.layer.borderColor = kALL_COLOR.CGColor;
    button.layer.borderWidth = .5;
    button.layer.cornerRadius = 5;
    
    [view addSubview:button];

    
    return view;
}

#pragma mark 修改就诊人
- (void)modifyAction:(UIButton *)sender{
    
    ModifyTreatmentViewController *modifyTreatmentViewController = ModifyTreatmentViewController.new;
    modifyTreatmentViewController.operationMode = TreatmentOperationModeModify;
    modifyTreatmentViewController.title = @"修改就诊人";
    [self.navigationController pushViewController:modifyTreatmentViewController animated:YES];
    
}

#pragma mark 选择支付方式View
- (UIView *)paymentMethodViewWithFrame:(CGRect)frame{
    
    CGRect rect = CGRectMake(0,frame.origin.y,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,17,8,8)];
    dotImageView.image = [UIImage imageNamed:@"reg_circle"];
    [view addSubview:dotImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,10,150,20)];
    titleLabel.text = @"选择支付方式";
    titleLabel.font = [UIFont fontWithName:kFontName size:16];
    titleLabel.textColor = kFontColor_Contacts;
    [view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth-20,1)];
    lineView.backgroundColor = kBackgroundColor;
    [view addSubview:lineView];
    
    [checkboxArray removeAllObjects];
    UIView *pmListView1 = [self pmListViewWithFrame:CGRectMake(0,CGRectGetMaxY(lineView.frame)+5,self.viewWidth/2,50) text:@"第三方支付"];
    [view addSubview:pmListView1];
    pmListView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(thirdPartyPaymentClicked:)];
    [pmListView1 addGestureRecognizer:viewTapGesture];
    
    
    UIView *pmListView2 = [self pmListViewWithFrame:CGRectMake(self.viewWidth/2,CGRectGetMaxY(lineView.frame)+5,self.viewWidth/2,50) text:@"现场支付"];
    [view addSubview:pmListView2];
    pmListView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(siteClicked:)];
    [pmListView2 addGestureRecognizer:viewTapGesture2];
    
    return view;
}

- (UIView *)pmListViewWithFrame:(CGRect)frame text:(NSString *)text{
    
    CGRect rect = CGRectMake(frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    view.Id = text;
    
    UIImageView *checkboxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,15,20,20)];
    checkboxImageView.image = [UIImage imageNamed:@"checkbox_not_select"];
    [view addSubview:checkboxImageView];
    checkboxImageView.type = @(NO);
    [checkboxArray addObject:checkboxImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(checkboxImageView.frame)+8,15,80,20)];
    titleLabel.text = text;
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    titleLabel.textColor = kFontColor_Contacts;
    [view addSubview:titleLabel];
    
    view.value = checkboxImageView;
    
    return view;
}

#pragma mark 点击第三方支付
- (void)thirdPartyPaymentClicked:(UITapGestureRecognizer *)snder{
    UIImageView *imageView0 = snder.view.value;
    UIImageView *imageView1 = checkboxArray[1];
    
    imageView0.image = [UIImage imageNamed:@"checkbox_not_select"];
    imageView1.image = [UIImage imageNamed:@"checkbox_not_select"];
    
    BOOL checkbox = [imageView0.type  boolValue];
    if (!checkbox) {
        tableViewHideFlag = YES;
        imageView0.image = [UIImage imageNamed:@"checkbox_select"];
        
    }else{
        tableViewHideFlag = NO;
        imageView0.image = [UIImage imageNamed:@"checkbox_not_select"];
    }
    checkbox = !checkbox;
    imageView0.type = @(checkbox);
    
    [self displayView];

}

#pragma mark 点击现场支付
- (void)siteClicked:(UITapGestureRecognizer *)snder{
    UIImageView *imageView1 = snder.view.value;
    UIImageView *imageView0 = checkboxArray[0];

    imageView0.image = [UIImage imageNamed:@"checkbox_not_select"];
    imageView1.image = [UIImage imageNamed:@"checkbox_not_select"];
    
    BOOL checkbox = [imageView1.type  boolValue];
    if (!checkbox) {
        imageView1.image = [UIImage imageNamed:@"checkbox_select"];
        
    }else{
        imageView1.image = [UIImage imageNamed:@"checkbox_not_select"];
    }
    checkbox = !checkbox;
    imageView1.type = @(checkbox);
    imageView0.type = @(NO);

    if (!tableViewHideFlag) {
        [self displayView];
    }
}

#pragma mark 显示／影藏支付View
- (void)displayView{
    
    tableViewHideFlag = !tableViewHideFlag;
    
    CGRect tRect = _tableView.frame;
    CGRect bRect = commitButton.frame;
    
    if (!tableViewHideFlag) {
        tRect.size.height = tableViewHeight;
        bRect.origin.y += tableViewHeight;
        
    }else{
        
        tRect.size.height = 0;
        bRect.origin.y -= tableViewHeight;
        [_tableView setHidden:YES];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(bRect)+5);
    
    [UIView animateWithDuration:.3 animations:^{
        _tableView.frame = tRect;
        commitButton.frame = bRect;
    } completion:^(BOOL finished) {
        if (!tableViewHideFlag) {
            [_tableView setHidden:NO];
        }
    }];
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

- (void)commitAction:(UIButton *)sender{
    
}

@end
