//
//  CaseHistoryDetailViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "CaseHistoryDetailViewController.h"
#import "SJAvatarBrowser.h"



@interface CaseHistoryDetailViewController (){
    UIView *images;
}

@end

@implementation CaseHistoryDetailViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self initThisView];
    [self uploadImages];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{

    NSArray *valueArray = @[
                            @{@"title":@"就 诊 人",@"value":@"韩梅梅"},
                            @{@"title":@"就诊日期",@"value":@"2016-06-21 周二 上午"},
                            @{@"title":@"医    生",@"value":@"郭应强 主任医师"},
                            @{@"title":@"就诊卡号",@"value":@"13697723479"}
                            ];
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 200);
    UIView *deptView = [UIView new];
    deptView.backgroundColor = [UIColor whiteColor];
    deptView.frame = frame;
    [self.scrollView addSubview:deptView];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,40)];
    tempLabel.text = @"   产科";
    tempLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [deptView addSubview:tempLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(tempLabel.frame),self.viewWidth-20,1)];
    lineLabel.backgroundColor = kBackgroundColor;
    [deptView addSubview:lineLabel];
    
    CGRect tempFrame = CGRectMake(0, CGRectGetMaxY(tempLabel.frame)+1,self.viewWidth, 40);
    int h = 1;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSDictionary *data = valueArray[i];
        UIView *testView = [self addViewWithFrame:tempFrame data:data];
        [deptView addSubview:testView];
        if (i < valueArray.count-1) {
            
            lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(tempFrame),self.viewWidth-20,1)];
            lineLabel.backgroundColor = kBackgroundColor;
            [deptView addSubview:lineLabel];

            tempFrame = CGRectMake(0, CGRectGetMaxY(tempFrame)+h,self.viewWidth, 40);
        }
    }
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+10,self.viewWidth,230);
    UIView *doctorView = [UIView new];
    doctorView.backgroundColor = [UIColor whiteColor];
    doctorView.frame = frame;
    [self.scrollView addSubview:doctorView];
    
    tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,40)];
    tempLabel.text = @"   医嘱";
    tempLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [doctorView addSubview:tempLabel];
    
    lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(tempLabel.frame),self.viewWidth-20,1)];
    lineLabel.backgroundColor = kBackgroundColor;
    [doctorView addSubview:lineLabel];
    
    IQTextView *textView = [[IQTextView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(lineLabel.frame),self.viewWidth-20,179)];
    textView.userInteractionEnabled = NO;
    textView.text = @"泸州，四川省地级市，古称“江阳”，别称酒城、江城。位于四川省东南部，长江和沱江交汇处，川滇黔渝结合部区域中心城市。2014年，泸州城镇化率达45.1%，中心城区建成区面积达113.17平方公里、人口达111.59万人。[1]\n泸州是长江上游重要港口，为四川省第一大港口和第三大航空港，成渝经济区重要的商贸物流中心，长江上游重要的港口城市，世界级白酒产业基地，国内唯一拥有两大知名白酒品牌的城市，中国唯一的酒城。";
    [doctorView addSubview:textView];
    
    valueArray = @[
                   @{@"title":@"药品清单",@"value":@"费用：279元"},
                   @{@"title":@"抗病毒冲剂",@"value":@"一日一次，一次二片"},
                   @{@"title":@"抗病毒颗粒",@"value":@"一日一次，一次一包"},
                   @{@"title":@"感冒清",@"value":@"一日一次，一次三片"},
                   @{@"title":@"白加黑",@"value":@"一日一次，一次三片"}
                   ];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth, 200);
    UIView *drugView = [UIView new];
    drugView.backgroundColor = [UIColor whiteColor];
    drugView.frame = frame;
    [self.scrollView addSubview:drugView];
    tempFrame = CGRectMake(0,0,self.viewWidth, 40);
    h = 1;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        UIColor *textColor = kFontColor;
        if (i == 0) {
            textColor = RGB(244, 166, 146);
        }
        NSDictionary *data = valueArray[i];
        UIView *testView = [self drugViewWithFrame:tempFrame data:data textColor:textColor];
        [drugView addSubview:testView];
        if (i < valueArray.count-1) {
            
            lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(tempFrame),self.viewWidth-20,1)];
            lineLabel.backgroundColor = kBackgroundColor;
            [drugView addSubview:lineLabel];
            
            tempFrame = CGRectMake(0, CGRectGetMaxY(tempFrame)+h,self.viewWidth, 40);
        }
    }
    
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+10,self.viewWidth,126);
    UIView *imageView = [UIView new];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.frame = frame;
    [self.scrollView addSubview:imageView];
    
    tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,40)];
    tempLabel.text = @"   上传检查报告／处方单";
    tempLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [imageView addSubview:tempLabel];
    
    lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(tempLabel.frame),self.viewWidth-20,1)];
    lineLabel.backgroundColor = kBackgroundColor;
    [imageView addSubview:lineLabel];
    
    images = [UIView new];
    CGRect tempframe = CGRectZero;
    tempframe.origin.x = 0;
    tempframe.origin.y = CGRectGetMaxY(lineLabel.frame)+5;
    tempframe.size.height = kImageSize;
    tempframe.size.width = self.viewWidth;;
    images.frame = tempframe;
    [imageView addSubview:images];
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame));
}

- (UIView *)addViewWithFrame:(CGRect)frame data:(NSDictionary *)data{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, (CGRectGetHeight(frame)-20)/2,60, 20);
    titleLabel1.text = data[@"title"];
    titleLabel1.textColor = kFontColor;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:titleLabel1];
    
    UILabel *valueLabel = [UILabel new];
    valueLabel.frame = CGRectMake(80, (CGRectGetHeight(frame)-20)/2,self.viewWidth-90, 20);
    valueLabel.text = data[@"value"];
    valueLabel.textColor = kFontColor_Contacts;
    valueLabel.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:valueLabel];
    
    return view;
    
}

- (UIView *)drugViewWithFrame:(CGRect)frame data:(NSDictionary *)data textColor:(UIColor *)textColor{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, (CGRectGetHeight(frame)-20)/2,80, 20);
    titleLabel1.text = data[@"title"];
    titleLabel1.textColor = kFontColor_Contacts;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:titleLabel1];
    
    UILabel *valueLabel = [UILabel new];
    valueLabel.frame = CGRectMake(80, (CGRectGetHeight(frame)-20)/2,self.viewWidth-90, 20);
    valueLabel.text = data[@"value"];
    valueLabel.textColor = textColor;
    valueLabel.textAlignment = NSTextAlignmentRight;
    valueLabel.font = [UIFont fontWithName:kFontName size:12];
    [view addSubview:valueLabel];
    
    return view;
}

- (void)uploadImages{

    CGFloat f = (self.viewWidth - kImageSize*kImageNumber)/(kImageNumber+1);
    
    NSArray *attachment = @[[UIImage imageNamed:@"0.jpeg"],[UIImage imageNamed:@"1.jpeg"]];
    for (int i=0;i<attachment.count;i++){
        CGRect frame = CGRectMake(i*kImageSize+f*(i+1),0,kImageSize,kImageSize);
        UIImageView *imageView = [[UIImageView  alloc] initWithFrame:frame];
        imageView.image = attachment[i];
//        [self setImageWithURL:attachment[i][@"file_path"] imageView:imageView placeholderImage:nil];
        [images addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewAction:)];
        [imageView addGestureRecognizer:viewTapGesture];
    }

}

- (void)imageViewAction:(UITapGestureRecognizer *)sender{
    [SJAvatarBrowser showImage:(UIImageView *)sender.view avatar:NO];
}

@end
