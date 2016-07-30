//
//  UserCenterViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/13.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UIView+BindValues.h"
#import "ModifyUserInfoViewController.h"
#import "CommonTreatmentViewController.h"
#import "MyNewsViewController.h"
#import "ChatMainViewController.h"
#import "MyBespokeViewController.h"
#import "CaseHistoryViewController.h"
#import "MyPostsViewController.h"
#import "MedicineRemindViewController.h"

@interface UserCenterViewController (){
    NSDictionary *myInfo;
}

@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    self.title = @"我";
    
    myInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kMyInfo];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initThisView{
    CGRect frame = CGRectMake(0,0,self.viewWidth, 70);
    UIView *headView = [self headViewWithFrame:frame];
    [self.scrollView addSubview:headView];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5,self.viewWidth, 56);
    UIImage *not_common_seedoctor = [UIImage imageNamed:@"not_common_seedoctor"];
//    UIImage *not_my_message = [UIImage imageNamed:@"not_my_message"];
//    UIImage *not_my_registration = [UIImage imageNamed:@"not_my_registration"];
//    UIImage *not_my_consult = [UIImage imageNamed:@"not_my_consult"];
    UIImage *not_my_invitation = [UIImage imageNamed:@"not_my_invitation"];
    UIImage *not_my_case_history = [UIImage imageNamed:@"not_my_case_history"];
//    UIImage *not_my_collect = [UIImage imageNamed:@"not_my_collect"];
    UIImage *not_takedrug_remind = [UIImage imageNamed:@"not_takedrug_remind"];
    
    NSArray *valuesArray = @[@"常用就诊人"/*,@"我的消息",@"我的预约",@"我的咨询"*/,@"我的帖子",@"我的病历"/*,@"我的收藏"*/,@"吃药提醒"];
    NSArray *imageArrays = @[not_common_seedoctor/*,not_my_message,not_my_registration,not_my_consult*/,not_my_invitation,not_my_case_history/*,not_my_collect*/,not_takedrug_remind];
    int h = 5;//控制行间距
    for(NSUInteger i = 0;i < valuesArray.count;i++){
        NSString *title = valuesArray[i];
        UIImage *image = imageArrays[i];
        UIView *testView = [self drawListView:frame title:title image:image action:@selector(listDataClicked:) tag:i];
        [self.scrollView addSubview:testView];
        if (i==1 || i==2 || i==3 || i==5) {
            h = 1;
        }else{
           h = 5;
        }
        if (i < valuesArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 56);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (UIView *)headViewWithFrame:(CGRect)frame{
    
    UIView *headView = [[UIView alloc] initWithFrame:frame];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13,(CGRectGetHeight(frame) -50)/2,50,50)];
    
    [self roundImageView:userImageView withColor:nil];
    [self setImageWithURL:myInfo[@"icon"] imageView:userImageView placeholderImage:[UIImage imageNamed:@"image_icon"]];
    [headView addSubview:userImageView];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImageView.frame)+5,CGRectGetHeight(frame)/2 -15,self.viewWidth -80 ,20)];
    nameLabel.text = myInfo[@"realname"];
    nameLabel.textColor = kALL_COLOR;
    nameLabel.font = [UIFont fontWithName:kFontName size:16];
    [headView addSubview:nameLabel];
    
    UILabel *loginIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImageView.frame)+5,CGRectGetMaxY(nameLabel.frame),self.viewWidth -80 ,20)];
    loginIdLabel.text = [NSString stringWithFormat:@"登录账号:%@",myInfo[@"mobile"]];
    loginIdLabel.textColor = kFontColor;
    loginIdLabel.font = [UIFont fontWithName:kFontName size:12];
    [headView addSubview:loginIdLabel];
    
    UIImageView *jtImageView = [UIImageView new];
    jtImageView.frame = CGRectMake(self.viewWidth-40,(CGRectGetHeight(frame) -30)/2,30, 30);
    jtImageView.image = [UIImage imageNamed:@"箭头"];
    [headView addSubview:jtImageView];
    
    headView.userInteractionEnabled = YES;
    UITapGestureRecognizer *headViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewClicked:)];
    [headView addGestureRecognizer:headViewTapGesture];
    
    return headView;
}

- (UIView *)drawListView:(CGRect)frame title:(NSString *)title image:(UIImage *)image action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.value = title;
    view.tag = tag;
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(15, (56-30)/2,30, 30);
    imageView.image = image;
    [view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(48, 8,150, 40);
    label.text = title;
    label.textColor = kFontColor_Contacts;
    label.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label];
    
    UIImageView *jtImageView = [UIImageView new];
    jtImageView.frame = CGRectMake(self.viewWidth-40, 13,30, 30);
    jtImageView.image = [UIImage imageNamed:@"箭头"];
    [view addSubview:jtImageView];
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}

- (void)headViewClicked:(UITapGestureRecognizer *)sender{
    
    ModifyUserInfoViewController *modifyUserInfoViewController = ModifyUserInfoViewController.new;
    modifyUserInfoViewController.myInfo = myInfo;
    [self.navigationController pushViewController:modifyUserInfoViewController animated:YES];
}

// @"常用就诊人",@"我的消息",@"我的预约",@"我的咨询",@"我的帖子",@"我的病历",@"我的收藏",@"吃药提醒";

- (void)listDataClicked:(UITapGestureRecognizer *)sender{
    
//    NSInteger tag = sender.view.tag;
    NSString *title = sender.view.value;
    HeadViewController *tempVC;
    if ([title isEqualToString:@"常用就诊人"]) {
        
        CommonTreatmentViewController *commonTreatmentViewController = CommonTreatmentViewController.new;
        commonTreatmentViewController.myInfo = myInfo;
        tempVC = commonTreatmentViewController;
    }
    
    if ([title isEqualToString:@"我的帖子"]) {
        tempVC = MyPostsViewController.new;
    }
    
    if ([title isEqualToString:@"我的病历"]) {
        
        CaseHistoryViewController *caseHistoryViewController = CaseHistoryViewController.new;
        caseHistoryViewController.myInfo = myInfo;
        tempVC = caseHistoryViewController;
    }
    
    if ([title isEqualToString:@"我的病历"]) {
        tempVC = CaseHistoryViewController.new;
    }
    
    if ([title isEqualToString:@"吃药提醒"]) {
        tempVC = MedicineRemindViewController.new;
    }
    

    tempVC.title = title;
    [self.navigationController pushViewController:tempVC animated:YES];
    
}

@end
