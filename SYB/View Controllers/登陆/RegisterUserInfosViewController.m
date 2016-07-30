//
//  RegisterUserInfosViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/30.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "RegisterUserInfosViewController.h"
#import "WHUCalendarPopView.h"
#import "TypeListViewController.h"
#import "QRadioButton.h"

@interface RegisterUserInfosViewController ()<QRadioButtonDelegate,UITextFieldDelegate>{
    UITextField *nameTextField;
    UITextField *nationTextField;
    UITextField *identityNumberTextField;
    UITextField *birthdayTextField;
    UITextField *addressTextField;
    
    WHUCalendarPopView *calendarPopView;
    
    NSNumber *sex;
    NSString *id_type;
}

@end

@implementation RegisterUserInfosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料填写";
    
    UIButton *_btnBack = [self defaultBackButtonWithTitle:@""];
    [_btnBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnBack setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnBack];
    
    calendarPopView = [[WHUCalendarPopView alloc] init];
    
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

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth,40);
    UITextField *textField;
    UIView *testView = [self drawViewWithFrame:frame title:@"姓       名" textField:&textField read:NO action:nil must:YES tag:300];
    [self.scrollView addSubview:testView];
    nameTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    view1.frame = frame;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(15,10,60,20);
    titleLabel.text = @"性       别";
    titleLabel.textColor = kFontColor_Contacts;
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [view1 addSubview:titleLabel];
    
    QRadioButton *radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"0"];
    radio1.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+2, 10, 50, 20);
    [radio1 setTitle:@"男" forState:UIControlStateNormal];
    [radio1 setTitleColor:kFontColor_Contacts forState:UIControlStateNormal];
    [radio1.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
    [view1 addSubview:radio1];
    radio1.tag = 100;
    [radio1 setChecked:YES];
    
    QRadioButton *radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"0"];
    radio2.frame = CGRectMake(150, 10, 50, 20);
    [radio2 setTitle:@"女" forState:UIControlStateNormal];
    [radio2 setTitleColor:kFontColor_Contacts forState:UIControlStateNormal];
    [radio2.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
    [view1 addSubview:radio2];
    radio2.tag = 101;
    [self.scrollView addSubview:view1];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"民       族" textField:&textField read:YES action:@selector(nationAction:) must:YES tag:301];
    [self.scrollView addSubview:testView];
    nationTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    view2.frame = frame;
    
    UILabel *titleLabel2 = [UILabel new];
    titleLabel2.frame = CGRectMake(15,10,60,20);
    titleLabel2.text = @"证件类型";
    titleLabel2.textColor = kFontColor_Contacts;
    titleLabel2.font = [UIFont fontWithName:kFontName size:14];
    [view2 addSubview:titleLabel2];
    
    QRadioButton *radio3 = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    radio3.frame = CGRectMake(CGRectGetMaxX(titleLabel2.frame)+2, 10, 80, 20);
    [radio3 setTitle:@"身份证" forState:UIControlStateNormal];
    [radio3 setTitleColor:kFontColor_Contacts forState:UIControlStateNormal];
    [radio3.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
    [view2 addSubview:radio3];
    radio3.tag = 103;
    [radio3 setChecked:YES];
    
    QRadioButton *radio4 = [[QRadioButton alloc] initWithDelegate:self groupId:@"1"];
    radio4.frame = CGRectMake(150, 10, 80, 20);
    [radio4 setTitle:@"其它" forState:UIControlStateNormal];
    [radio4 setTitleColor:kFontColor_Contacts forState:UIControlStateNormal];
    [radio4.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
    [view2 addSubview:radio4];
    radio4.tag = 104;
    
    [self.scrollView addSubview:view2];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"证件号码" textField:&textField read:NO action:nil must:YES tag:302];
    [self.scrollView addSubview:testView];
    identityNumberTextField = textField;
    identityNumberTextField.delegate = self;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"出生年月" textField:&textField read:YES action:@selector(birthdayAction:) must:NO tag:303];
    [self.scrollView addSubview:testView];
    birthdayTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"联系地址" textField:&textField read:NO action:nil must:NO tag:304];
    [self.scrollView addSubview:testView];
    addressTextField = textField;
    
    frame = CGRectMake(10,CGRectGetMaxY(frame)+25,self.viewWidth-20, 40);
    UIButton *okBtn = [self addUIButtonWithFrame:frame title:@"确认"];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:okBtn];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if ([identityNumberTextField isEqual:textField] && [id_type isEqualToString:@"身份证"]) {
        if (range.location > 17) {
            return NO;
        }
    }
    
    return YES;
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

//代理方法
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    NSLog(@"changed to %@ in %@",@(index),groupId);
}

- (void)nationAction:(UITapGestureRecognizer *)sender{
    
    NSString *nationStr = @"汉族,壮族,满族,回族,苗族,维吾尔族,土家族,彝族,蒙古族,藏族,布依族,侗族,瑶族,朝鲜族,白族,哈尼族,哈萨克族,黎族,傣族,畲族,傈僳族,仡佬族,东乡族,高山族,拉祜族,水族,佤族,纳西族,羌族,土族,仫佬族,锡伯族,柯尔克孜族,达斡尔族,景颇族,毛南族,撒拉族,布朗族,塔吉克族,阿昌族,普米族,鄂温克族,怒族,京族,基诺族,德昂族,保安族,俄罗斯族,裕固族,乌孜别克族,门巴族,鄂伦春族,独龙族,塔塔尔族,赫哲族,珞巴族,其他";
    
    TypeListViewController *typeListViewController = TypeListViewController.new;
    typeListViewController.infos = [nationStr componentsSeparatedByString:@","];
    [typeListViewController setTypeListBlock:^(id value) {
        nationTextField.text = value;
    }];
    [self.navigationController pushViewController:typeListViewController animated:YES];
    
}

- (void)birthdayAction:(UITapGestureRecognizer *)sender{
    
    __block UITextField *tempTextField = birthdayTextField;
    calendarPopView.onDateSelectBlk=^(NSDate* date){
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [format stringFromDate:date];
        tempTextField.text = dateString;
    };
    [calendarPopView show];
}

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId{
    
    if ([groupId isEqualToString:@"0"]) {
        if (radio.tag == 100) {
            sex = @(1);//1:男 2:女
        }else{
            sex = @(2);
        }
    }else{
        id_type = radio.titleLabel.text;
    }
}

- (void)okAction:(UIButton *)sender{
    
    NSString *realname = nameTextField.text;
    if (realname.length == 0) {
        [MBProgressHUD showError:@"请输入姓名" toView:ShareAppDelegate.window];
        return;
    }
    NSString *id_card = identityNumberTextField.text;
    if (id_card.length == 0) {
        [MBProgressHUD showError:@"请输入证件号码" toView:ShareAppDelegate.window];
        return;
    }

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.mobile forKey:@"mobile"];
    [parameters setObject:self.sms forKey:@"sms"];
    [parameters setObject:self.password forKey:@"password"];
    
    [parameters setObject:realname forKey:@"realname"];
    [parameters setObject:id_card forKey:@"id_card"];
    [parameters setObject:id_type forKey:@"id_type"];
    [parameters setObject:sex forKey:@"sex"];
    
    NSString *ent_id = [[NSUserDefaults standardUserDefaults] objectForKey:kEntId];
    [parameters setObject:ent_id forKey:@"ent_id"];
    
    if (nationTextField.text.length >0) {
        [parameters setObject:nationTextField.text forKey:@"nation"];
    }
    
    if (addressTextField.text.length >0) {
        [parameters setObject:addressTextField.text forKey:@"address"];
    }
    
    
    if (birthdayTextField.text.length >0) {
        [parameters setObject:birthdayTextField.text forKey:@"birthday"];
    }

    [ContactsRequest registerRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        NSString *token = response.message[@"tip"];
        if (token.length >0) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:kToken];
            [[NSUserDefaults standardUserDefaults] synchronize];
        
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *targetVC = [storyboard instantiateInitialViewController];
            UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
            win.rootViewController = targetVC;
            
            [self requestMyInfoData];

        }else{
            [MBProgressHUD showError:@"登录失败" toView:ShareAppDelegate.window];
        }
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];
    
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

@end
