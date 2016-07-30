//
//  ModifyTreatmentViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/16.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ModifyTreatmentViewController.h"
#import "WHUCalendarPopView.h"
#import "TypeListViewController.h"
#import "QRadioButton.h"

@interface ModifyTreatmentViewController ()<QRadioButtonDelegate,UITextFieldDelegate>{
    
    UITextField *nameTextField;
    UITextField *nationTextField;
    UITextField *identityNumberTextField;
    UITextField *birthdayTextField;
    UITextField *addressTextField;
    UITextField *jobTextField;
    UITextField *phoneTextField;
    
    UITextField *treatmentTextField;
    UITextField *medicareTextField;
    
    NSNumber *sex;
    NSString *id_type;
    
    WHUCalendarPopView *calendarPopView;
    
    NSDictionary *modifyData;
}

@end

@implementation ModifyTreatmentViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    calendarPopView = [[WHUCalendarPopView alloc] init];
    [self initThisView];
    
    [self bindingWhenModifyData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
   
    QRadioButton *radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"0"];
    radio2.frame = CGRectMake(150, 10, 50, 20);
    [radio2 setTitle:@"女" forState:UIControlStateNormal];
    [radio2 setTitleColor:kFontColor_Contacts forState:UIControlStateNormal];
    [radio2.titleLabel setFont:[UIFont fontWithName:kFontName size:14]];
    [view1 addSubview:radio2];
    radio2.tag = 101;
    
    if (self.operationMode ==TreatmentOperationModeInsert) {
        [radio1 setChecked:YES];
    }else{
        
    }
    
    [self.scrollView addSubview:view1];
    
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
    
//    1、姓名（必填）
//    2、性别（必填）
//    3、手机号码（必填）
//    4、证件类型（必填）
//    5、证件号码（必填）
//    6、民族
//    7、出生年月
//    8、联系地址
//    9、从事职业
//    10、就诊卡号
//    11、医保卡号
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"证件号码" textField:&textField read:NO action:nil must:YES tag:302];
    [self.scrollView addSubview:testView];
    identityNumberTextField = textField;
    identityNumberTextField.delegate = self;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"手机号码" textField:&textField read:NO action:nil must:YES tag:302];
    [self.scrollView addSubview:testView];
    phoneTextField = textField;
    phoneTextField.delegate = self;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"民       族" textField:&textField read:YES action:@selector(nationAction:) must:NO tag:301];
    [self.scrollView addSubview:testView];
    nationTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"出生年月" textField:&textField read:YES action:@selector(birthdayAction:) must:NO tag:303];
    [self.scrollView addSubview:testView];
    birthdayTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"联系地址" textField:&textField read:NO action:nil must:NO tag:304];
    [self.scrollView addSubview:testView];
    addressTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"从事职业" textField:&textField read:NO action:nil must:NO tag:307];
    [self.scrollView addSubview:testView];
    jobTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"就诊卡号" textField:&textField read:NO action:nil must:NO tag:305];
    [self.scrollView addSubview:testView];
    treatmentTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"医保卡号" textField:&textField read:NO action:nil must:NO tag:306];
    [self.scrollView addSubview:testView];
    medicareTextField = textField;
    
    if (self.operationMode == TreatmentOperationModeModify) {
        frame = CGRectMake(10,CGRectGetMaxY(frame)+10,self.viewWidth/2-15,40);
        UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        delButton.frame = frame;
        delButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
        delButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [delButton setTitle:@"删除就诊人" forState:UIControlStateNormal];
        [delButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [delButton setBackgroundColor:RGB(244, 166, 146)];
        [delButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:delButton];
        
        frame.origin.x = self.viewWidth/2 +5;
    }else{
        frame = CGRectMake(10,CGRectGetMaxY(frame)+10,self.viewWidth -20,40);
    }

    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = frame;
    saveButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    saveButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setBackgroundColor:kALL_COLOR];
    [saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:saveButton];
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)-20);

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

- (void)nationAction:(UITapGestureRecognizer *)sender{
    
    NSString *nationStr = @"汉族,壮族,满族,回族,苗族,维吾尔族,土家族,彝族,蒙古族,藏族,布依族,侗族,瑶族,朝鲜族,白族,哈尼族,哈萨克族,黎族,傣族,畲族,傈僳族,仡佬族,东乡族,高山族,拉祜族,水族,佤族,纳西族,羌族,土族,仫佬族,锡伯族,柯尔克孜族,达斡尔族,景颇族,毛南族,撒拉族,布朗族,塔吉克族,阿昌族,普米族,鄂温克族,怒族,京族,基诺族,德昂族,保安族,俄罗斯族,裕固族,乌孜别克族,门巴族,鄂伦春族,独龙族,塔塔尔族,赫哲族,珞巴族,其他";
    
    TypeListViewController *typeListViewController = TypeListViewController.new;
    typeListViewController.infos = [nationStr componentsSeparatedByString:@","];
    [typeListViewController setTypeListBlock:^(id value) {
        nationTextField.text = value;
    }];
    [self.navigationController pushViewController:typeListViewController animated:YES];
    
}


- (void)deleteAction:(UIButton *)sender{
    
    NSString *mobile = phoneTextField.text;
    if (mobile.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:ShareAppDelegate.window];
        return;
    }
    
    [ContactsRequest userDeleteContactRequestParameters:@{@"mobile":mobile} success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        NSString *tip = response.message[@"tip"];
        if ([tip isEqualToString:@"成功"]) {
            [self backAction];
        }
    } fail:^(BOOL notReachable, NSString *desciption) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
        
    }];

}

- (void)saveAction:(UIButton *)sender{
    
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
    NSString *mobile = phoneTextField.text;
    if (mobile.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:ShareAppDelegate.window];
        return;
    }
    
    __block NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [data setObject:mobile forKey:@"mobile"];
    [data setObject:realname forKey:@"realname"];
    [data setObject:id_card forKey:@"id_card"];
    [data setObject:id_type forKey:@"id_type"];
    [data setObject:sex forKey:@"sex"];
    
    if (nationTextField.text.length >0) {
        [data setObject:nationTextField.text forKey:@"nation"];
    }
    
    if (addressTextField.text.length >0) {
        [data setObject:addressTextField.text forKey:@"address"];
    }
    
    
    if (birthdayTextField.text.length >0) {
        [data setObject:birthdayTextField.text forKey:@"birthday"];
    }
    
    if (jobTextField.text.length >0) {
        [data setObject:jobTextField.text forKey:@"job"];
    }
    
    if (treatmentTextField.text.length >0) {
        [data setObject:treatmentTextField.text forKey:@"patient_card"];
    }
    
    if (medicareTextField.text.length >0) {
        [data setObject:medicareTextField.text forKey:@"medical_card"];
    }
    
    [data setObject:modifyData[@"id"] forKey:@"id"];
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    //修改模式
    if (self.operationMode != TreatmentOperationModeInsert) {
        [ContactsRequest userUpdateContactRequestParameters:data success:^(PiblicHttpResponse *response) {
            [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
            NSString *tip = response.message[@"tip"];
            if ([tip isEqualToString:@"成功"]) {
                [self backAction];
                
                if (self.operationMode == TreatmentOperationModeMainModify) {
                    NSMutableDictionary *myInfo = [[[NSUserDefaults standardUserDefaults] objectForKey:kMyInfo] mutableCopy];
                    for (NSString *key in data){
                        if (![data[key] isEqual:myInfo[key]]) {
                            [myInfo setObject:data[key] forKey:key];
                        }
                    }
                    [[NSUserDefaults standardUserDefaults] setObject:myInfo forKey:kMyInfo];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    self.block(myInfo);
                }
                
            }
        } fail:^(BOOL notReachable, NSString *desciption) {
            [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
            [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
            
        }];

    }else{//新加模式
    
        [ContactsRequest userAddContactRequestParameters:data success:^(PiblicHttpResponse *response) {
            [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
            NSString *tip = response.message[@"tip"];
            if ([tip isEqualToString:@"成功"]) {
                [self backAction];
            }
        } fail:^(BOOL notReachable, NSString *desciption) {
            [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
            [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
            
        }];
        
//        self.block(realname);
      
    }
    
}

- (UIView *)drawViewWithFrame:(CGRect)frame title:(NSString *)title textField:(UITextField **)textField must:(BOOL)must{
    
    UIView *tempView1 = [UIView new];
    tempView1.backgroundColor = [UIColor whiteColor];
    tempView1.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, 10,60, 20);
    titleLabel1.text = title;
    titleLabel1.textColor = kFontColor_Contacts;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [tempView1 addSubview:titleLabel1];
    
    UITextField *_textField = [UITextField new];
    _textField.frame = CGRectMake(CGRectGetMaxX(titleLabel1.frame)+2, 5,self.viewWidth-135, 30);
    _textField.textColor = kFontColor_Contacts;
    _textField.font = [UIFont fontWithName:kFontName size:14];
    _textField.placeholder = [NSString stringWithFormat:@"请输入%@",title];
    [tempView1 addSubview:_textField];
    
    *textField = _textField;
    
    if (must) {
        UILabel *starLabel1 = [UILabel new];
        starLabel1.frame = CGRectMake(self.viewWidth -15, 10,10, 20);
        starLabel1.text = @"*";
        starLabel1.textColor = [UIColor redColor];
        [tempView1 addSubview:starLabel1];
    }
    
    return tempView1;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([phoneTextField isEqual:textField]) {
        if (range.location > 10) {
            return NO;
        }
    }
    
    if ([identityNumberTextField isEqual:textField] && [id_type isEqualToString:@"身份证"]) {
        if (range.location > 17) {
            return NO;
        }
    }
    
    return YES;
}

- (void)updateInfo:(id)obj withRefreshSupperView:(TreatmentRefreshSupperViewBLock)block{
    self.block = block;
    
    if (obj) {
        modifyData = obj;
    }
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

- (void)bindingWhenModifyData{
    
    if (self.operationMode == TreatmentOperationModeInsert) {
        return;
    }
    
    nameTextField.text = modifyData[@"realname"]?modifyData[@"realname"]:@"";
    nationTextField.text = modifyData[@"nation"]?modifyData[@"nation"]:@"";
    identityNumberTextField.text = modifyData[@"id_card"]?modifyData[@"id_card"]:@"";
    birthdayTextField.text = modifyData[@"birthday"]?modifyData[@"birthday"]:@"";
    addressTextField.text = modifyData[@"address"]?modifyData[@"address"]:@"";
    jobTextField.text = modifyData[@"job"]?modifyData[@"job"]:@"";
    phoneTextField.text = modifyData[@"mobile"]?modifyData[@"mobile"]:@"";
    treatmentTextField.text = modifyData[@"patient_card"]?modifyData[@"patient_card"]:@"";
    medicareTextField.text = modifyData[@"medical_card"]?modifyData[@"medical_card"]:@"";
    
    QRadioButton *radio1 = [self.scrollView viewWithTag:100];
    QRadioButton *radio2 = [self.scrollView viewWithTag:101];
    
    if ([modifyData[@"sex"] integerValue] == 1) {
        [radio1 setChecked:YES];
        [radio2 setChecked:NO];
    }else{
        [radio1 setChecked:NO];
        [radio2 setChecked:YES];
    }
    
    QRadioButton *radio3 = [self.scrollView viewWithTag:103];
    QRadioButton *radio4 = [self.scrollView viewWithTag:104];

    if ([modifyData[@"id_type"] isEqualToString:@"身份证"]) {
        [radio3 setChecked:YES];
        [radio4 setChecked:NO];
    }else{
        [radio3 setChecked:NO];
        [radio4 setChecked:YES];
    }
}

@end
