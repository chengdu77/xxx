//
//  PaymentViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/24.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentAlreadyViewController.h"
#import "PaymentNotViewController.h"
#import "PaymentCell.h"

@interface PaymentViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    
    NSMutableArray *_options;
}

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    _options = [NSMutableArray array];
    [_options addObject:@{@"name":@"药品缴费",@"cost":@"145.00元",@"paymentFlag":@(YES)}];
    [_options addObject:@{@"name":@"体检缴费",@"cost":@"35.00元",@"paymentFlag":@(NO)}];
    
    [self initThisView];
    [self initFooterView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    if (_tableView) {
        [_tableView removeFromSuperview];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, self.viewWidth,self.viewHeight-80)];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.scrollView addSubview:_tableView];
    _tableView.backgroundColor = kBackgroundColor;
    
    UINib *nib = [UINib nibWithNibName:@"PaymentCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"PaymentCell"];
    
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _options.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PaymentCell *cell = (PaymentCell *)[tableView dequeueReusableCellWithIdentifier:@"PaymentCell"];
    if (!cell) {
        cell = [[PaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PaymentCell"];
    }
    
    NSDictionary *data = _options[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.nameLabel.text = data[@"name"];
    cell.costLabel.text = data[@"cost"];
    cell.paymentFlag = [data[@"paymentFlag"] boolValue];
    
    if (cell.paymentFlag) {
        cell.stateLabel.text = @"已支付";
        cell.stateLabel.backgroundColor = RGB(244, 166, 146);
        cell.stateLabel.textColor = [UIColor whiteColor];
    }else{
        cell.stateLabel.text = @"未支付";
        cell.stateLabel.textColor = RGB(244, 166, 146);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = _options[indexPath.row];
    BOOL paymentFlag = [data[@"paymentFlag"] boolValue];
    if (paymentFlag){
        PaymentAlreadyViewController *paymentAlreadyViewController = PaymentAlreadyViewController.new;
        paymentAlreadyViewController.title = self.title;
        [self.navigationController pushViewController:paymentAlreadyViewController animated:YES];
    }else{
        PaymentNotViewController *paymentNotViewController = PaymentNotViewController.new;
        paymentNotViewController.title = self.title;
        [self.navigationController pushViewController:paymentNotViewController animated:YES];
    }
}


- (void)initFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.viewHeight -80, self.viewWidth,80)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,5,100,20)];
    titleLabel.text = @"   增加我的账单";
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [footerView addSubview:titleLabel];
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(10,30, self.viewWidth-80,40)];
    bView.backgroundColor = kBackgroundColor;
    [footerView addSubview:bView];
    
    bView.layer.borderWidth = .5;
    bView.layer.borderColor = kBackgroundColor.CGColor;
    bView.layer.cornerRadius = 3;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,30,30)];
    imageView.image = [UIImage imageNamed:@"zxing_image"];
    [bView addSubview:imageView];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(40,5,self.viewWidth-120,30)];
    textField.font = [UIFont fontWithName:kFontName size:14];
    textField.placeholder = @"请输入挂号编号或扫描条码";
    [bView addSubview:textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(bView.frame)+5,30,60,40);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:RGB(244, 166, 146)];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [button addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    button.layer.borderWidth = .5;
    button.layer.borderColor = RGB(244, 166, 146).CGColor;
    button.layer.cornerRadius = 3;
    
}

- (void)addAction:(UIButton *)sender{
    
}

@end
