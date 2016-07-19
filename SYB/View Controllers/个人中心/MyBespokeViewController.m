//
//  MyBespokeViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MyBespokeViewController.h"
#import "WaitingDoctorViewController.h"


@interface MyBespokeViewController (){
    NSArray *valueArray;
}

@end

@implementation MyBespokeViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    valueArray = @[@{@"doctor":@"郭应强 主任医师",@"dept":@"心血管外科",@"patient":@"李磊",@"time":@"2016-06-21 周二 下午",@"cost":@"15.00元"},
                   @{@"doctor":@"王晓东 副主任医师",@"dept":@"甲状腺乳腺外科",@"patient":@"韩梅梅",@"time":@"2016-06-20 周一 下午",@"cost":@"25.00元"}
                   ];
    
    [self initThisView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 115);
    int h = 1;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSDictionary *data = valueArray[i];
        UIView *testView = [self drawListView:frame data:data  action:@selector(listDataClicked:) tag:i];
        [self.scrollView addSubview:testView];
        if (i < valueArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 115);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (UIView *)drawListView:(CGRect)frame data:(NSDictionary *)data action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10,5,self.viewWidth, 20);
    [view addSubview:label];
    
    NSString *name = data[@"doctor"];
    NSRange r = [name rangeOfString:@" "];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:name];
    [str addAttribute:NSForegroundColorAttributeName value:kFontColor range:NSMakeRange(r.location,str.length-r.location)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(r.location,str.length -r.location)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:16] range:NSMakeRange(0,r.location-1)];
    label.attributedText = str;
    
    
    UILabel *label1 = [UILabel new];
    label1.frame = CGRectMake(0,CGRectGetMaxY(label.frame)+5,self.viewWidth-100, 20);
    label1.text = [NSString stringWithFormat:@"   %@",data[@"dept"]];
    label1.textColor = kFontColor;
    label1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label1];
    
    UILabel *costLabel = [UILabel new];
    costLabel.frame = CGRectMake(self.viewWidth-70,CGRectGetMaxY(label.frame)+5,60, 20);
    costLabel.text = data[@"cost"];
    costLabel.textColor = RGB(244, 166, 146);
    costLabel.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:costLabel];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(10,CGRectGetMaxY(label1.frame)+5,self.viewWidth-20, 1);
    line.backgroundColor = kBackgroundColor;
    [view addSubview:line];
    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(10,CGRectGetMaxY(line.frame)+5,self.viewWidth, 20);
    label2.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label2];
    
    name = [NSString stringWithFormat:@"就诊人 %@",data[@"patient"]];
    r = [name rangeOfString:@" "];
    str = [[NSMutableAttributedString alloc] initWithString:name];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(r.location,str.length -r.location)];
    [str addAttribute:NSForegroundColorAttributeName value:kFontColor range:NSMakeRange(0,r.location)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(0,r.location)];
    label2.attributedText = str;
    
    
    UILabel *label3 = [UILabel new];
    label3.frame = CGRectMake(10,CGRectGetMaxY(label2.frame)+5,self.viewWidth, 20);
    label3.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label3];
    
    name = [NSString stringWithFormat:@"就诊日期 %@",data[@"time"]];;
    r = [name rangeOfString:@" "];
    str = [[NSMutableAttributedString alloc] initWithString:name];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(r.location,str.length -r.location)];
    [str addAttribute:NSForegroundColorAttributeName value:kFontColor range:NSMakeRange(0,r.location)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(0,r.location)];
    label3.attributedText = str;
    
    
    CGRect tFrame =CGRectMake(self.viewWidth-70,(frame.size.height - 26)/2+25,60,26);
    UIButton *yyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yyButton.frame = tFrame;
    yyButton.titleLabel.font = [UIFont fontWithName:kFontName size:12];
    yyButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [yyButton setTitle:@"重发短信" forState:UIControlStateNormal];
    [yyButton setTitleColor:kALL_COLOR forState:UIControlStateNormal];
    [yyButton setBackgroundColor:[UIColor whiteColor]];
    [yyButton addTarget:self action:@selector(yyAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:yyButton];
    yyButton.layer.borderColor = kALL_COLOR.CGColor;
    yyButton.layer.borderWidth = .5;
    yyButton.layer.cornerRadius = 5;
    
//    UIImageView *jtImageView = [UIImageView new];
//    jtImageView.frame = CGRectMake(self.viewWidth-40, (CGRectGetHeight(frame)-30)/2+15,30, 30);
//    jtImageView.image = [UIImage imageNamed:@"箭头"];
//    [view addSubview:jtImageView];
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}

- (void)listDataClicked:(UITapGestureRecognizer *)sender{
    
    WaitingDoctorViewController *waitingDoctorViewController = WaitingDoctorViewController.new;
    [self.navigationController pushViewController:waitingDoctorViewController animated:YES];

}

- (void)yyAction:(UIButton *)sender{
    NSString *str = [NSString stringWithFormat:@"sms://%@",@"18628117895"];
    NSURL *myURL = [NSURL URLWithString:str];
    
    [[UIApplication sharedApplication] openURL:myURL];
    
}



@end
