//
//  RegisterUserInfosViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/30.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "RegisterUserInfosViewController.h"
#import "ZYRadioButton.h"
#import "WHUCalendarPopView.h"
#import "TypeListViewController.h"

@interface RegisterUserInfosViewController (){
    UITextField *nameTextField;
    UITextField *nationTextField;
    UITextField *identityNumberTextField;
    UITextField *birthdayTextField;
    UITextField *addressTextField;
    
      WHUCalendarPopView *calendarPopView;
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
    
    UIView *radioView = [self addRadioViewWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+2,(CGRectGetHeight(frame) -20)/2,CGRectGetWidth(frame)-77, 20) items:@[@"男",@"女"] groupId:@"0"];
    
    [view1 addSubview:radioView];
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
    
    UIView *credentialView = [self addRadioViewWithFrame:CGRectMake(CGRectGetMaxX(titleLabel2.frame)+2,(CGRectGetHeight(frame) -20)/2,CGRectGetWidth(frame)-77, 20) items:@[@"身份证",@"其它"] groupId:@"1"];
    
    [view2 addSubview:credentialView];
    [self.scrollView addSubview:view2];
    

    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"证件号码" textField:&textField read:NO action:nil must:YES tag:302];
    [self.scrollView addSubview:testView];
    identityNumberTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"出生年月" textField:&textField read:YES action:@selector(birthdayAction:) must:YES tag:303];
    [self.scrollView addSubview:testView];
    birthdayTextField = textField;
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth, 40);
    testView = [self drawViewWithFrame:frame title:@"联系地址" textField:&textField read:NO action:nil must:YES tag:304];
    [self.scrollView addSubview:testView];
    addressTextField = textField;
    
    frame = CGRectMake(10,CGRectGetMaxY(frame)+25,self.viewWidth-20, 40);
    UIButton *okBtn = [self addUIButtonWithFrame:frame title:@"确认"];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:okBtn];
    
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

- (UIView *)addRadioViewWithFrame:(CGRect)frame items:(NSArray *)items groupId:(NSString *)groupId{
    
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    //初始化单选按钮控件
    ZYRadioButton *rb1 = [[ZYRadioButton alloc] initWithGroupId:groupId index:0];
    ZYRadioButton *rb2 = [[ZYRadioButton alloc] initWithGroupId:groupId index:1];
    
    //设置Frame
    rb1.frame = CGRectMake(10,0,20,20);
    
    //初始化第一个单选按钮的UILabel
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(40, 0, 60, 20)];
    label1.text = items[0];
    label1.textColor = kFontColor_Contacts;
    label1.font = [UIFont fontWithName:kFontName size:14];
    [containerView addSubview:label1];
    
    rb2.frame = CGRectMake(110,0,20,20);
    
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(140,0, 60, 20)];
    label2.text = items[1];
    label2.textColor = kFontColor_Contacts;
    label2.font = [UIFont fontWithName:kFontName size:14];
    [containerView addSubview:label2];
    
    //按照GroupId添加观察者
    [ZYRadioButton addObserverForGroupId:groupId observer:self];
    
    //添加到视图容器
    [containerView addSubview:rb1];
    [containerView addSubview:rb2];
    
    return containerView;
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

- (void)okAction:(UIButton *)sender{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *targetVC = [storyboard instantiateInitialViewController];
    UIWindow *win = [[[UIApplication sharedApplication] delegate] window];
    win.rootViewController = targetVC;

}



@end
