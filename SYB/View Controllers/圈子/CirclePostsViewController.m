//
//  CirclePostsViewController.m
//  SYB
//
//  Created by WangJincai on 16/7/20.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "CirclePostsViewController.h"
#import "UIView+BindValues.h"
#import "PostViewController.h"
#import "PostDetailsViewController.h"

@interface CirclePostsViewController (){
    NSArray *listArray;

}

@end

@implementation CirclePostsViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestListData];
}

- (void)initThisView{
    
    for(UIView *view in self.scrollView.subviews){
        [view removeFromSuperview];
    }
    
    CGRect frame = CGRectMake(0, 0, self.viewWidth, 80);
    UIView *headView = [self headViewWithFrame:frame];
    [self.scrollView addSubview:headView];
    
    frame.origin.y = CGRectGetMaxY(frame)+5;
    for (int i = 0;i<listArray.count;i++) {
        UIView *view = [self listViewWithFrame:frame data:listArray[i]];
        [self.scrollView addSubview:view];
        frame = view.frame;
        if (i < listArray.count -1) {
            frame.origin.y = CGRectGetMaxY(frame)+5;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (UIView *)headViewWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
  
    UIImageView *txImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 58, 58)];
    [self setImageWithURL:self.info[@"icon"] imageView:txImageView placeholderImage:[UIImage imageNamed:@"icon_beauty"]];
    [view addSubview:txImageView];
    
    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(76, 12, 179, 21)];
    nameLable.text = self.info[@"name"];
    nameLable.font = [UIFont fontWithName:kFontName size:14];
    nameLable.textColor = kFontColor_Contacts;
    [view addSubview:nameLable];
    
    UIImageView *msgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(77, 44, 18, 18)];
    msgImageView.image = [UIImage imageNamed:@"topicimg"];
    [view addSubview:msgImageView];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(96, 44, 179, 18)];
    msgLabel.font = [UIFont fontWithName:kFontName size:12];
    msgLabel.textColor = kFontColor;
    msgLabel.text = [NSString stringWithFormat:@"话题：%@",self.info[@"msg"]?self.info[@"msg"]:@"0"];
    [view addSubview:msgLabel];
    
    CGRect tFrame = CGRectMake(self.viewWidth-80,(frame.size.height - 26)/2-5,60,26);
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    postButton.frame = tFrame;
    postButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    postButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [postButton setTitle:@"发帖" forState:UIControlStateNormal];
    [postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postButton setBackgroundColor:RGB(244, 166, 146)];
    [postButton addTarget:self action:@selector(postAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:postButton];
    postButton.layer.borderColor = RGB(244, 166, 146).CGColor;
    postButton.layer.borderWidth = .5;
    postButton.layer.cornerRadius = 2;
    
    return view;

}

- (void)postAction:(id)sender{
    
    PostViewController *postViewController = [PostViewController new];
    postViewController.moduleId = self.moduleId;
    [self.navigationController pushViewController:postViewController animated:YES];
}

- (UIView *)listViewWithFrame:(CGRect)frame data:(NSDictionary *)data{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.value = data;
    
    CGRect tFrame = CGRectMake(5,5,self.viewWidth-10,20);
    UILabel *desLabel = [self adaptiveLabelWithFrame:tFrame detail:data[@"des"] fontSize:14];
    [view addSubview:desLabel];
    tFrame = desLabel.frame;
    
    UIImageView *txImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,CGRectGetMaxY(tFrame)+5, 18, 18)];
    [self setImageWithURL:data[@"puser"][@"icon"] imageView:txImageView placeholderImage:[UIImage imageNamed:@"image_icon"]];
    [self roundImageView:txImageView withColor:nil];
    [view addSubview:txImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(txImageView.frame)+5,CGRectGetMaxY(tFrame)+5, 80, 18)];
    nameLabel.font = [UIFont fontWithName:kFontName size:12];
    nameLabel.textColor = kFontColor;
    nameLabel.text = data[@"puser"][@"real_name"];
    [view addSubview:nameLabel];
    
    NSString *create_time = data[@"create_time"];
    NSRange range = {5,5};
    create_time = [create_time substringWithRange:range];
    
    UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewWidth-110,CGRectGetMaxY(tFrame)+5, 18, 18)];
    timeImageView.image = [UIImage imageNamed:@"my_consult_time"];
    [view addSubview:timeImageView];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeImageView.frame)+5,CGRectGetMaxY(tFrame)+5,35, 18)];
    timeLabel.font = [UIFont fontWithName:kFontName size:12];
    timeLabel.textColor = kFontColor;
    timeLabel.text = create_time;
    [view addSubview:timeLabel];
    
    UIImageView *msgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(timeLabel.frame)+2,CGRectGetMaxY(tFrame)+5, 18, 18)];
    msgImageView.image = [UIImage imageNamed:@"topicimg"];
    [view addSubview:msgImageView];
    
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(msgImageView.frame)+5,CGRectGetMaxY(tFrame)+5,40, 18)];
    msgLabel.font = [UIFont fontWithName:kFontName size:12];
    msgLabel.textColor = kFontColor;
    msgLabel.text = [NSString stringWithFormat:@"%@",data[@"revert_count"]];
    [view addSubview:msgLabel];
    
    frame.size.height = CGRectGetHeight(tFrame) +33;
    view.frame = frame;
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listViewCliecked:)];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
    
}

- (void)requestListData{
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    NSDictionary *parameters = @{@"moduleId":self.moduleId};
    [ContactsRequest bbsContentListRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        listArray = response.messages;
        
        [self initThisView];
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];
}

- (void)listViewCliecked:(UITapGestureRecognizer *)sender{
    UIView *view = sender.view;
    NSDictionary *data = view.value;
    
    PostDetailsViewController *postDetailsViewController = PostDetailsViewController.new;
    postDetailsViewController.content = data[@"des"];
    postDetailsViewController.Id = data[@"id"];
    postDetailsViewController.moduleId = self.moduleId;
    postDetailsViewController.title_ = data[@"title"];
    [self.navigationController pushViewController:postDetailsViewController animated:YES];
    
}


@end
