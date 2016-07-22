//
//  RegisterPasswordViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/30.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "RegisterPasswordViewController.h"
#import "RegisterUserInfosViewController.h"

@interface RegisterPasswordViewController (){
    UITextField *passwordTextField;
    UITextField *passwordTextField2;
}

@end

@implementation RegisterPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
    
    UIButton *_btnBack = [self defaultBackButtonWithTitle:@""];
    [_btnBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnBack setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnBack];
    
    [self initThisView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

-(UIButton *)defaultBackButtonWithTitle:(NSString *)title{
    UIButton *button = [self defaultRightButtonWithTitle:title];
    return button;
}

-(UIButton *)defaultRightButtonWithTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 65, 35);
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return btn;
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UITextField *textField;
    UIView *testView = [self drawViewWithFrame:frame title:@"密       码" textField:&textField read:NO action:nil must:YES tag:0];
    [self.scrollView addSubview:testView];
    textField.secureTextEntry = YES;
    passwordTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+10,self.viewWidth, 40);
    UIView *testView1 = [self drawViewWithFrame:frame title:@"确认密码" textField:&textField read:NO action:nil must:YES tag:1];
    [self.scrollView addSubview:testView1];
    textField.secureTextEntry = YES;
    passwordTextField2 = textField;
    
    frame = CGRectMake(10,CGRectGetMaxY(frame)+25,self.viewWidth-20, 40);
    UIButton *nextBtn = [self addUIButtonWithFrame:frame title:@"下一步"];
    nextBtn.tag = 101;
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:nextBtn];
}

- (UIButton *)addUIButtonWithFrame:(CGRect)frame title:(NSString *)title{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.backgroundColor = kALL_COLOR;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = kALL_COLOR.CGColor;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = .5;
    
    return btn;
}

- (void)nextAction:(UIButton *)sender{
    
    if (passwordTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:ShareAppDelegate.window];
        return;
    }
    
    if (passwordTextField2.text.length == 0) {
        [MBProgressHUD showError:@"请输入确认密码" toView:ShareAppDelegate.window];
        return;
    }
    
    if (![passwordTextField.text isEqualToString:passwordTextField2.text]) {
        [MBProgressHUD showError:@"两次输入密码不一致" toView:ShareAppDelegate.window];
        return;
    }
    
    RegisterUserInfosViewController *registerUserInfosViewController = RegisterUserInfosViewController.new;
    registerUserInfosViewController.mobile = self.mobile;
    registerUserInfosViewController.sms = self.sms;
    registerUserInfosViewController.password = passwordTextField.text;
    [self.navigationController pushViewController:registerUserInfosViewController animated:YES];
}



@end
