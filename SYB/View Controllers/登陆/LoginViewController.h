//
//  LoginViewController.h
//  JCDB
//
//  Created by WangJincai on 15/12/31.
//  Copyright © 2015年 WJC.com. All rights reserved.
//

#import "HeadViewController.h"

@interface LoginViewController : UIViewController{

    IBOutlet UITextField *userTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *registerButton;
    
    IBOutlet UISwitch *remberMeSwitch;
    
    IBOutlet UIImageView *logoImageView;
    
    IBOutlet UIImageView *userImageView;
    IBOutlet UIImageView *passwordImageView;
}



- (IBAction)loginActoin:(id)sender;

- (IBAction)switchAction:(id)sender;

- (IBAction)registerAction:(id)sender;

- (IBAction)forgetAction:(id)sender;

@end
