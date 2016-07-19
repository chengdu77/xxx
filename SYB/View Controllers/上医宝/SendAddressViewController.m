//
//  SendAddressViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/26.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "SendAddressViewController.h"
#import "UIView+BindValues.h"

@interface SendAddressViewController (){
    
    NSMutableArray *textFieldArray;
    
    UIView *expandView;
    UIView *footerView;
    BOOL expandFlag;
}

@end

@implementation SendAddressViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    self.title = @"填写收货地址";
    
    textFieldArray = [NSMutableArray array];
    [self initFirstView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initFirstView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UILabel *detialAddrLabel = [[UILabel alloc] initWithFrame:frame];
    detialAddrLabel.text = @"   收货人信息";
    detialAddrLabel.textColor = kFontColor_Contacts;
    detialAddrLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:detialAddrLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 56);
    NSArray *valueArray = @[@"联  系  人",@"就诊时间",@"地       址",@"联系电话",@"公       司",@"邮       编"];
    UITextField *textField = nil;
    int h = 1;//控制行间距
    for(NSUInteger i = 0;i < valueArray.count;i++){
        NSString *title = valueArray[i];
        UIView *testView = [self drawViewWithFrame:frame title:title textField:&textField read:NO must:YES tag:i];
        [self.scrollView addSubview:testView];
        [textFieldArray addObject:textField];
        if (i < valueArray.count-1) {
            frame = CGRectMake(0, CGRectGetMaxY(frame)+h,self.viewWidth, 56);
        }
    }
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth, 40);
    UIView *tempView = [[UIView alloc] initWithFrame:frame];
    tempView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:tempView];
    
    UILabel *costListLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0,100,40)];
    costListLabel.text = @"   药品清单";
    costListLabel.textColor = kFontColor_Contacts;
    costListLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [tempView addSubview:costListLabel];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewWidth -70,0,60, 40)];
    textLabel.text = @"展开查看";
    textLabel.tag = 3000;
    textLabel.textColor = kALL_COLOR;
    textLabel.font = [UIFont fontWithName:kFontName size:14.0];
    [tempView addSubview:textLabel];
    
    tempView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expandClicked:)];
    [tempView addGestureRecognizer:tapGesture];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+1,self.viewWidth,0);
    expandView = [[UIView alloc] initWithFrame:frame];
    expandView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:expandView];
    [expandView setHidden:YES];
    
    CGRect tempFrame = CGRectMake(0,0,self.viewWidth, 40);
    UIColor *textColor1 = kFontColor_Contacts;
 
    h = 1;
    for(NSUInteger i = 0;i < self.detailArray.count;i++){
        NSDictionary *data = self.detailArray[i];
        UIView *testView = [self childViewWithFrame:tempFrame data:data textColor1:textColor1 textColor2:nil flag:YES];
        [expandView addSubview:testView];
        if (i < self.detailArray.count-1) {
            
            UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(i==0?0:10,CGRectGetMaxY(tempFrame),self.viewWidth-(i==0?0:20),1)];
            lineLabel.backgroundColor = kBackgroundColor;
            [expandView addSubview:lineLabel];
            
            tempFrame = CGRectMake(0, CGRectGetMaxY(tempFrame)+h,self.viewWidth, 40);
        }
    }
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth, 105);
    footerView = [[UIView alloc] initWithFrame:frame];
    tempView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:footerView];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,40)];
    tmpView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:tmpView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10,0,self.viewWidth -20,40);
    button.backgroundColor = kALL_COLOR;
    [button setTitle:@"填好了" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [button addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);

}

- (UIView *)drawViewWithFrame:(CGRect)frame title:(NSString *)title textField:(UITextField **)textField read:(BOOL)read must:(BOOL)must tag:(NSInteger)tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(15,(CGRectGetHeight(frame) -20)/2,60, 20);
    titleLabel.text = title;
    titleLabel.textColor = kFontColor_Contacts;
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:titleLabel];
    
    UITextField *valueTextField= [UITextField new];
    valueTextField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+2,(CGRectGetHeight(frame) -20)/2,self.viewWidth-135, 20);
    valueTextField.textColor = kFontColor_Contacts;
    valueTextField.font = [UIFont fontWithName:kFontName size:14];
    valueTextField.userInteractionEnabled = !read;
    NSString *placeholder = read?@"点击":@"输入";
    NSString *str = [self removeIntermediateSpace:title];
    
    valueTextField.placeholder = [NSString stringWithFormat:@"请%@%@",placeholder,str];
    [view addSubview:valueTextField];
    
    valueTextField.value = str;
    valueTextField.must = @(must);
    valueTextField.type = @(read);
    
    *textField = valueTextField;
    
//    view.userInteractionEnabled = YES;
//    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewAction:)];
//    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}

- (UIView *)childViewWithFrame:(CGRect)frame data:(NSDictionary *)data  textColor1:(UIColor *)textColor1 textColor2:(UIColor *)textColor2 flag:(BOOL)flag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, (CGRectGetHeight(frame)-20)/2,flag?120:80, 20);
    titleLabel1.text = data[@"title"];
    titleLabel1.textColor = textColor1?textColor1:kFontColor;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:titleLabel1];
    
//    UILabel *valueLabel = [UILabel new];
//    valueLabel.frame = CGRectMake(flag?120:80, (CGRectGetHeight(frame)-20)/2,self.viewWidth-(flag?130:90), 20);
//    valueLabel.text = data[@"value"];
//    valueLabel.textColor = textColor2?textColor2:kFontColor_Contacts;
//    valueLabel.font = [UIFont fontWithName:kFontName size:14];
//    valueLabel.textAlignment = flag?NSTextAlignmentRight:NSTextAlignmentLeft;
//    [view addSubview:valueLabel];
    
    return view;
}

- (void)expandClicked:(UITapGestureRecognizer *)sender{
    
    CGRect tRect = expandView.frame;
    CGRect bRect = footerView.frame;
    
    CGFloat height = 40*self.detailArray.count +self.detailArray.count -1;
    
    if (!expandFlag) {
        tRect.size.height = height;
        bRect.origin.y += height;
    }else{
        tRect.size.height = 0;
        bRect.origin.y -= height;
    }
    
    expandFlag = !expandFlag;
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(bRect)+5);
    
    [UIView animateWithDuration:.3 animations:^{
        expandView.frame = tRect;
        footerView.frame = bRect;
    } completion:^(BOOL finished) {
        [expandView setHidden:!expandFlag];
        expandView.alpha = expandFlag?1.0:0.0;
        UILabel *label = [self.scrollView viewWithTag:3000];
        label.text = expandFlag?@"收缩清单":@"展开查看";
    }];
    
}

- (void)okAction:(UIButton *)sender{
    
}


@end
