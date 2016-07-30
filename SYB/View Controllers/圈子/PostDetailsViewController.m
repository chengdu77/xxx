//
//  PostDetailsViewController.m
//  SYB
//
//  Created by WangJincai on 16/7/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController (){
    NSArray *listArray;
    
    UITextField *textField;
}

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
     self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self requestListData];
    [self initFooterView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (UIView *)headViewWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    CGRect tFrame = CGRectMake(5,0,self.viewWidth-10,20);
    UILabel *desLabel = [self adaptiveLabelWithFrame:tFrame detail:self.content fontSize:14];
    [view addSubview:desLabel];
    tFrame = desLabel.frame;
    
    frame.size.height = tFrame.size.height;
    view.frame = frame;
    
    return view;
}

- (void)initFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.viewHeight -50, self.viewWidth,50)];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(10,5, self.viewWidth-80,40)];
    bView.backgroundColor = kBackgroundColor;
    [footerView addSubview:bView];
    
    bView.layer.borderWidth = .5;
    bView.layer.borderColor = kBackgroundColor.CGColor;
    bView.layer.cornerRadius = 3;
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,self.viewWidth-80,30)];
    textField.font = [UIFont fontWithName:kFontName size:14];
    textField.placeholder = @"回复楼主";
    [bView addSubview:textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(bView.frame)+5,5,60,40);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:RGB(244, 166, 146)];
    [button setTitle:@"回帖" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [button addTarget:self action:@selector(repliesAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    button.layer.borderWidth = .5;
    button.layer.borderColor = RGB(244, 166, 146).CGColor;
    button.layer.cornerRadius = 3;
    
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth,20);
    UIView *headView = [self headViewWithFrame:frame];
    [self.scrollView addSubview:headView];
    frame = headView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(frame)+1;
    frame.size.width = self.viewWidth;
    for (int i = 0;i<listArray.count;i++) {
        NSString *floor = [self translation:[NSString stringWithFormat:@"%@",@(i+1)]];
        UIView *view = [self listViewWithFrame:frame data:listArray[i] floor:floor];
        [self.scrollView addSubview:view];
        frame = view.frame;
        if (i < listArray.count -1) {
            frame.origin.y = CGRectGetMaxY(frame)+5;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (UIView *)listViewWithFrame:(CGRect)frame data:(NSDictionary *)data floor:(NSString *)floor{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
  
    CGRect tFrame = CGRectMake(5,5,18,18);
    UIImageView *txImageView = [[UIImageView alloc] initWithFrame:tFrame];
    [self setImageWithURL:data[@"puser"][@"icon"] imageView:txImageView placeholderImage:[UIImage imageNamed:@"image_icon"]];
    [self roundImageView:txImageView withColor:nil];
    [view addSubview:txImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(txImageView.frame)+5,5, 80, 18)];
    nameLabel.font = [UIFont fontWithName:kFontName size:12];
    nameLabel.textColor = kFontColor;
    nameLabel.text = data[@"puser"][@"realname"];
    [view addSubview:nameLabel];
    
    UILabel *floorLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewWidth-90,5, 80, 18)];
    floorLabel.font = [UIFont fontWithName:kFontName size:12];
    floorLabel.textColor = kFontColor;
    floorLabel.textAlignment = NSTextAlignmentRight;
    floorLabel.text = [NSString stringWithFormat:@"%@楼",floor];
    [view addSubview:floorLabel];

    tFrame.origin.y = CGRectGetMaxY(tFrame)+5;
    tFrame.size.width = self.viewWidth - 10;
    UILabel *desLabel = [self adaptiveLabelWithFrame:tFrame detail:data[@"des"] fontSize:14];
    [view addSubview:desLabel];
    tFrame = desLabel.frame;
    
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
    
    NSString *revert_count = data[@"revert_count"]?data[@"revert_count"]:@"0";
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(msgImageView.frame)+5,CGRectGetMaxY(tFrame)+5,40, 18)];
    msgLabel.font = [UIFont fontWithName:kFontName size:12];
    msgLabel.textColor = kFontColor;
    msgLabel.text = [NSString stringWithFormat:@"%@",revert_count];
    [view addSubview:msgLabel];
    
    frame.size.height = CGRectGetHeight(desLabel.frame) +54;
    view.frame = frame;
    
//    view.userInteractionEnabled = YES;
//    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(listViewCliecked:)];
//    [view addGestureRecognizer:viewTapGesture];
    
    return view;
    
}

- (void)requestListData{
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    NSDictionary *parameters = @{@"Id":self.Id,@"page":@(1)};
    [ContactsRequest bbsContentDetailRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        listArray = response.messages;
        
        [self initThisView];
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];
}

#pragma mark 阿拉伯数字转化为汉语数字

- (NSString *)translation:(NSString *)arebic{
    NSString *str = arebic;
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]]){
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]]){
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]]){
                    [sums removeLastObject];
                }
            }else{
                sum = chinese_numerals[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum]){
                continue;
            }
        }
        
        [sums addObject:sum];
    }
    
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    NSLog(@"%@",str);
    NSLog(@"%@",chinese);
    return chinese;
}

- (void)repliesAction:(id)sender{
    
    NSString *des = textField.text;
    if (des.length ==0) {
        [MBProgressHUD showError:@"请输入回帖内容" toView:ShareAppDelegate.window];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    NSDictionary *parameters = @{@"module_id":self.moduleId,@"des":des,@"title":self.title_,@"parent_id":self.Id};
    [ContactsRequest bbsContentPostRequestParameters:parameters success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        
        [self requestListData];
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];

}


@end
