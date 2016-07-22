//
//  RegisterViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/29.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterPasswordViewController.h"


@interface RegisterViewController ()<UITextFieldDelegate>{
    UITextField *phoneTextField;
    UITextField *codeTextField;
  
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    self.hasTabBarFlag = YES;
    
    self.navigationController.navigationBar.barTintColor = kALL_COLOR;
    [super viewDidLoad];
    
    UIButton *_btnBack = [self defaultBackButtonWithTitle:@""];
    [_btnBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnBack setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnBack];
    
   
    [self initThisView];

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.hidden = NO;
}


-(void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UITextField *textField;
    UIView *testView = [self drawViewWithFrame:frame title:@"手机号" textField:&textField read:NO action:nil must:YES tag:0];
    [self.scrollView addSubview:testView];
    phoneTextField = textField;
    phoneTextField.delegate = self;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+10,self.viewWidth-140, 40);
    UIView *testView1 = [self drawViewWithFrame:frame title:@"验证码" textField:&textField read:NO action:nil must:YES tag:1];
    [self.scrollView addSubview:testView1];
    codeTextField = textField;
    
    UIButton *btn = [self addUIButtonWithFrame:CGRectMake(CGRectGetMaxX(testView1.frame)+5,CGRectGetMaxY(testView.frame)+10,self.viewWidth - CGRectGetMaxX(testView1.frame)-15, 40) title:@"获取验证码"];
    [btn addTarget:self action:@selector(codeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
    frame = CGRectMake(10,CGRectGetMaxY(frame)+25,self.viewWidth-20, 40);
    
    UIButton *nextBtn = [self addUIButtonWithFrame:frame title:@"下一步"];
    [nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.tag = 100;
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([phoneTextField isEqual:textField]) {
        if (range.location > 10) {
            return NO;
        }
    }
    
    return YES;
}



- (void)codeAction:(UIButton *)sender{
    
    if (phoneTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:ShareAppDelegate.window];
        return;
    }
    
    NSDictionary *parameters = @{@"mobile":phoneTextField.text};
    [ContactsRequest smsRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        NSLog(@"response:%@",response);
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];
    
}

- (void)nextAction:(UIButton *)sender{
    
    if (phoneTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:ShareAppDelegate.window];
        return;
    }
    
    if (codeTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入验证码" toView:ShareAppDelegate.window];
        return;
    }
    
    RegisterPasswordViewController *registerPasswordViewController = RegisterPasswordViewController.new;
    registerPasswordViewController.mobile = phoneTextField.text;
    registerPasswordViewController.sms = codeTextField.text;
    [self.navigationController pushViewController:registerPasswordViewController animated:YES];
    

}





@end
