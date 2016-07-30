//
//  LoginViewController.m
//  JCDB
//
//  Created by WangJincai on 15/12/31.
//  Copyright © 2015年 WJC.com. All rights reserved.
//

#import "LoginViewController.h"
#import "SIAlertView.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"


@interface LoginViewController ()<UITextFieldDelegate>{
    CGFloat _popoverWidth;
    Reachability *_reachability;
}

@property (nonatomic, strong) NSString *serviceIPInfo;
@property (nonatomic ,assign) CGFloat viewWidth;
    
@end

@implementation LoginViewController


- (BOOL)isExistenceNetwork{
    _reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];  // 测试服务器状态
    
    BOOL isExistenceNetwork;
    switch([_reachability currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = FALSE;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = TRUE;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = TRUE;
            break;
    }
    return  isExistenceNetwork;
}

-(void)alertNetworkStatus{
    
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"当前无网络，是否进行设置？"
                                          cancelButtonTitle:@"取消"
                                              cancelHandler:^(SIAlertView *alertView) {}
                                     destructiveButtonTitle:@"马上设置"
                                         destructiveHandler:^(SIAlertView *alertView) {
                                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
                                             
                                         }];
    alert.alignment=NSTextAlignmentLeft;
    [alert show];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden=YES;
    loginButton.backgroundColor = kLOGIN_COLOR;
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.borderColor = kLOGIN_COLOR.CGColor;
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.borderWidth = .5;
    
    registerButton.backgroundColor = kALL_COLOR;
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.borderColor = kALL_COLOR.CGColor;
    registerButton.layer.cornerRadius = 5;
    registerButton.layer.borderWidth = .5;
    
    remberMeSwitch.onTintColor = kALL_COLOR;
    
    userImageView.image = [UIImage imageNamed:@"账户"];
    passwordImageView.image = [UIImage imageNamed:@"密码"];
   
    self.viewWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    userTextField.textColor = [UIColor whiteColor];
    userTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kUSERNAME];
    userTextField.delegate = self;
    
    passwordTextField.textColor = [UIColor whiteColor];
    passwordTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:kPASSWORD];
    passwordTextField.delegate = self;
    
    BOOL REMBERFLAG = [[NSUserDefaults standardUserDefaults] boolForKey:kREMBERFLAG];
    [remberMeSwitch setOn:REMBERFLAG animated:NO];
    
    if ([self isExistenceNetwork]) {
    }else{
        [self alertNetworkStatus];
    }

    [_reachability startNotifier]; //开始监听,会启动一个run loop
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(notice:) name:kModifyPasswordNotification object:nil];
    
    UIImage *bgImage = [UIImage imageNamed:@"bg_login"];
    UIColor *bgColor = [UIColor colorWithPatternImage:bgImage];
    [self.view setBackgroundColor:bgColor];
}

- (void)viewUnDidLoad {
    [super viewDidLoad];
    
    [_reachability stopNotifier];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)notice:(NSNotification *)sender{
//    NSLog(@"%@",sender.userInfo[kPASSWORD]);
    passwordTextField.text = sender.userInfo[kPASSWORD];
}

#pragma mark 点击登陆按钮
- (IBAction)loginActoin:(id)sender {
    
    NSString *userName = userTextField.text;
    NSString *password = passwordTextField.text;
    if (userName.length == 0) {
        [MBProgressHUD showError:@"请输入账号" toView:ShareAppDelegate.window];
        return;
    }
    
    if (password.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:ShareAppDelegate.window];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    
    NSDictionary *parameters = @{@"mobile":userName,@"password":password};
    [ContactsRequest loginRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        NSString *token = response.message[@"tip"];
        if (token.length >0) {
            
            NSString *password = response.message[@"password"];
            NSString *loginName = response.message[@"loginName"];
            [[NSUserDefaults standardUserDefaults] setObject:loginName forKey:kHXLoginName];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:kHXPassword];
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:kToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self logining];
        }else{
            [MBProgressHUD showError:@"登录失败" toView:ShareAppDelegate.window];
        }
     
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];
    
}

#pragma mark 登陆到主界面
- (void)logining{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *targetVC = [storyboard instantiateInitialViewController];
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    win.rootViewController = targetVC;
    
    BOOL REMBERFLAG = NO;
    BOOL isButtonOn = [remberMeSwitch isOn];
    if (isButtonOn) {
        [[NSUserDefaults standardUserDefaults] setObject:userTextField.text forKey:kUSERNAME];
        [[NSUserDefaults standardUserDefaults] setObject:passwordTextField.text forKey:kPASSWORD];
        REMBERFLAG = YES;
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:REMBERFLAG forKey:kREMBERFLAG];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self requestMyInfoData];
}


- (void)requestMyInfoData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ContactsRequest userMyInfoRequestParameters:nil success:^(PiblicHttpResponse *response) {
            NSDictionary *myInfo = response.message;
            if (myInfo.count >0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSUserDefaults standardUserDefaults] setObject:myInfo forKey:kMyInfo];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                });
            }
        } fail:^(BOOL notReachable, NSString *desciption) {
     
        }];
    });
}


- (IBAction)switchAction:(UISwitch *)sender{
    
    NSString *USERNAME=@"";
    NSString *PASSWORD=@"";
    BOOL REMBERFLAG = NO;
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        USERNAME = userTextField.text;
        PASSWORD = passwordTextField.text;
        REMBERFLAG = YES;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:USERNAME forKey:kUSERNAME];
    [[NSUserDefaults standardUserDefaults] setObject:PASSWORD forKey:kPASSWORD];
    [[NSUserDefaults standardUserDefaults] setBool:REMBERFLAG forKey:kREMBERFLAG];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([userTextField isEqual:textField]) {
        if (range.location > 10) {
            return NO;
        }
    }
    
    if ([passwordTextField isEqual:textField]) {
        if (range.location > 20) {
            return NO;
        }
    }
   
    return YES;
}

- (IBAction)registerAction:(id)sender{
    RegisterViewController *registerViewController = RegisterViewController.new;
    registerViewController.title = @"注册";
    [self.navigationController pushViewController:registerViewController animated:YES];
    
}

- (IBAction)forgetAction:(id)sender{
    
}


@end
