//
//  MedicalRecordViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MedicalRecordViewController.h"

@interface MedicalRecordViewController (){
    NSArray *valueArray;
}

@end

@implementation MedicalRecordViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    valueArray = @[@{@"title":@"2016-06-21",@"name":@"郭应强 主任医师",@"dept":@"心血管外科",@"desc":@"就医结束了，赶紧完善你的病历吧"},
                   @{@"title":@"2016-06-20",@"name":@"王晓东 副主任医师",@"dept":@"甲状腺乳腺外科",@"desc":@"就医结束了，赶紧完善你的病历吧"}
                   ];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 125);
    int h = 0;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSDictionary *data = valueArray[i];
        UIView *testView = [self drawListView:frame data:data  action:@selector(listDataClicked:) tag:i];
        [self.scrollView addSubview:testView];
        if (i < valueArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 125);
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (UIView *)drawListView:(CGRect)frame data:(NSDictionary *)data action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth, 40)];
    titleLabel.text = [NSString stringWithFormat:@"   %@",data[@"title"]];
    titleLabel.font = [UIFont fontWithName:kFontName size:16.0];
    titleLabel.backgroundColor = kBackgroundColor;
    [view addSubview:titleLabel];

    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth, 20);
    [view addSubview:label];
    
    NSString *name = data[@"name"];
    NSRange r = [name rangeOfString:@" "];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:name];
    [str addAttribute:NSForegroundColorAttributeName value:kFontColor range:NSMakeRange(r.location,str.length-r.location)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:14] range:NSMakeRange(r.location,str.length -r.location)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontName size:16] range:NSMakeRange(0,r.location-1)];
    label.attributedText = str;

    
    UILabel *label1 = [UILabel new];
    label1.frame = CGRectMake(0,CGRectGetMaxY(label.frame)+5,self.viewWidth, 20);
    label1.text = [NSString stringWithFormat:@"   %@",data[@"dept"]];
    label1.textColor = kFontColor;
    label1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label1];
    
    UILabel *line = [UILabel new];
    line.frame = CGRectMake(20,CGRectGetMaxY(label1.frame)+5,self.viewWidth-40, 1);
    line.backgroundColor = kBackgroundColor;
    [view addSubview:line];
    
    UILabel *label2 = [UILabel new];
    label2.frame = CGRectMake(0,CGRectGetMaxY(line.frame)+5,self.viewWidth, 20);
    label2.text = [NSString stringWithFormat:@"   %@",data[@"desc"]];
    label2.textColor = kFontColor;
    label2.font = [UIFont fontWithName:kFontName size:12];
    [view addSubview:label2];
    
    
    UIImageView *jtImageView = [UIImageView new];
    jtImageView.frame = CGRectMake(self.viewWidth-40, (CGRectGetHeight(frame)-30)/2+15,30, 30);
    jtImageView.image = [UIImage imageNamed:@"箭头"];
    [view addSubview:jtImageView];
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}

- (void)listDataClicked:(UITapGestureRecognizer *)sender{

    
}

@end
