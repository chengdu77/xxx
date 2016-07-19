//
//  ModifypasswordViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ModifypasswordViewController.h"

@interface ModifypasswordViewController (){
    UITextField *oldPasswordTextField;
    UITextField *newPasswordTextField;
}

@end

@implementation ModifypasswordViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    
    [self initThisView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 56);
    
    UIView *tempView1 = [UIView new];
    tempView1.backgroundColor = [UIColor whiteColor];
    tempView1.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, 18,50, 20);
    titleLabel1.text = @"老密码";
    titleLabel1.textColor = kFontColor_Contacts;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [tempView1 addSubview:titleLabel1];
    
    oldPasswordTextField = [UITextField new];
    oldPasswordTextField.frame = CGRectMake(70, 18,self.viewWidth-90, 20);
    oldPasswordTextField.textColor = kFontColor_Contacts;
    oldPasswordTextField.font = [UIFont fontWithName:kFontName size:14];
    oldPasswordTextField.placeholder = @"请输入您的老密码";
    [tempView1 addSubview:oldPasswordTextField];
    
    [self.scrollView addSubview:tempView1];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 56);
    
    UIView *tempView2 = [UIView new];
    tempView2.backgroundColor = [UIColor whiteColor];
    tempView2.frame = frame;
    
    UILabel *titleLabel2 = [UILabel new];
    titleLabel2.frame = CGRectMake(15, 18,50, 20);
    titleLabel2.text = @"新密码";
    titleLabel2.textColor = kFontColor_Contacts;
    titleLabel2.font = [UIFont fontWithName:kFontName size:14];
    [tempView2 addSubview:titleLabel2];
    
    newPasswordTextField = [UITextField new];
    newPasswordTextField.frame = CGRectMake(70, 18,self.viewWidth-90, 20);
    newPasswordTextField.textColor = kFontColor_Contacts;
    newPasswordTextField.font = [UIFont fontWithName:kFontName size:14];
    newPasswordTextField.placeholder = @"请输入6位以上的字母或者数字";
    [tempView2 addSubview:newPasswordTextField];
    
    [self.scrollView addSubview:tempView2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10,CGRectGetMaxY(frame)+20,self.viewWidth -20,40);
    button.backgroundColor = kALL_COLOR;
    [button setTitle:@"修改保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
 
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:button];
}

- (void)buttonAction:(UIButton *)sender{
    
    NSString *oldStr = oldPasswordTextField.text;
    if (oldStr.length ==0) {
        [MBProgressHUD showError:@"请输入您的老密码" toView:ShareAppDelegate.window];
        [oldPasswordTextField becomeFirstResponder];
        return;
    }
    NSString *newStr = newPasswordTextField.text;
    
    if (newStr.length ==0) {
        [MBProgressHUD showError:@"请输入您的新密码" toView:ShareAppDelegate.window];
        [newPasswordTextField becomeFirstResponder];
        return;
    }

}

@end
