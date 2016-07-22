//
//  PostViewController.m
//  SYB
//
//  Created by WangJincai on 16/7/20.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController (){
    UITextField *titleTextField;
    
    IQTextView *textView;
}

@end

@implementation PostViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    UIBarButtonItem *commitButton = [[UIBarButtonItem alloc] initWithTitle:@"发帖"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(commitAction:)];
    NSArray *buttonArray = [[NSArray alloc]initWithObjects:commitButton,nil];
    self.navigationItem.rightBarButtonItems = buttonArray;
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 56);
    UITextField *textField = nil;
    UIView *testView = [self drawViewWithFrame:frame title:@"标题" textField:&textField read:NO action:nil must:NO tag:0];
    [self.scrollView addSubview:testView];
    titleTextField = textField;
    
    textView = [[IQTextView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth,self.viewHeight -CGRectGetMaxY(frame)+5)];
    
    [self.scrollView addSubview:textView];

}


- (void)commitAction:(id)sender {
    
    NSString *des = textView.text;
    if (des.length ==0) {
        [MBProgressHUD showError:@"请输入内容" toView:ShareAppDelegate.window];
        return;
    }
    
    NSString *title = titleTextField.text;
    if (title.length ==0) {
        title = @"";
    }
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    NSDictionary *parameters = @{@"module_id":self.moduleId,@"title":title,@"des":des};
    [ContactsRequest bbsContentPostRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        
        [self backAction];
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];

}

@end
