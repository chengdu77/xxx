//
//  ModifyTreatmentViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/16.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ModifyTreatmentViewController.h"

@interface ModifyTreatmentViewController (){
    
    UITextField *nameTextField;
    UITextField *sfzTextField;
    UITextField *sexTextField;
    UITextField *phoneTextField;
    
    UITextField *treatmentTextField;
    UITextField *medicareTextField;
}

@end

@implementation ModifyTreatmentViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 56);
    
    UITextField *textField;
    UIView *nameView = [self drawViewWithFrame:frame title:@"姓名" textField:&textField];
    nameTextField = textField;
    [self.scrollView addSubview:nameView];
    
    frame.origin.y = CGRectGetMaxY(frame)+1;
    UIView *sfzView = [self drawViewWithFrame:frame title:@"身份证" textField:&textField];
    sfzTextField = textField;
    [self.scrollView addSubview:sfzView];
    
    frame.origin.y = CGRectGetMaxY(frame)+1;
    UIView *sexView = [self drawViewWithFrame:frame title:@"性别" textField:&textField];
    sexTextField = textField;
    [self.scrollView addSubview:sexView];
    
    frame.origin.y = CGRectGetMaxY(frame)+1;
    UIView *phoneView = [self drawViewWithFrame:frame title:@"手机号码" textField:&textField];
    phoneTextField = textField;
    [self.scrollView addSubview:phoneView];
    
    
    frame.origin.y = CGRectGetMaxY(frame)+10;
    UIView *treatmentView = [self drawViewWithFrame:frame title:@"就诊卡号" textField:&textField];
    treatmentTextField = textField;
    [self.scrollView addSubview:treatmentView];
    
    frame.origin.y = CGRectGetMaxY(frame)+1;
    UIView *medicareView = [self drawViewWithFrame:frame title:@"医保卡号" textField:&textField];
    medicareTextField = textField;
    [self.scrollView addSubview:medicareView];
    
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+10,self.viewWidth,20);
    UILabel *treatmentIdLabel = [[UILabel alloc] initWithFrame:frame];
    treatmentIdLabel.text = @"  注意";
    treatmentIdLabel.font = [UIFont fontWithName:kFontName size:14];
    treatmentIdLabel.textColor = RGB(244, 166, 146);
    [self.scrollView addSubview:treatmentIdLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+2,self.viewWidth,20);
    UILabel *medicareIdLabel = [[UILabel alloc] initWithFrame:frame];
    medicareIdLabel.text = @"  在医院就医需要提供就诊卡号";
    medicareIdLabel.font = [UIFont fontWithName:kFontName size:12];
    medicareIdLabel.textColor = kFontColor;
    [self.scrollView addSubview:medicareIdLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+2,self.viewWidth,20);
    UILabel *cardIdLabel = [[UILabel alloc] initWithFrame:frame];
    cardIdLabel.text = @"  医保卡可以代替就诊卡使用";
    cardIdLabel.font = [UIFont fontWithName:kFontName size:12];
    cardIdLabel.textColor = kFontColor;
    [self.scrollView addSubview:cardIdLabel];
    
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

- (void)deleteAction:(UIButton *)sender{
    
}

- (void)saveAction:(UIButton *)sender{
    //修改模式
    if (self.operationMode == TreatmentOperationModeModify) {
        
    }else{//新加模式
        
        NSString *name = nameTextField.text;
        self.block(name);
        [self backAction];
    }
    
}

- (UIView *)drawViewWithFrame:(CGRect)frame title:(NSString *)title textField:(UITextField **)textField{
    
    UIView *tempView1 = [UIView new];
    tempView1.backgroundColor = [UIColor whiteColor];
    tempView1.frame = frame;
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.frame = CGRectMake(15, 18,60, 20);
    titleLabel1.text = title;
    titleLabel1.textColor = kFontColor_Contacts;
    titleLabel1.font = [UIFont fontWithName:kFontName size:14];
    [tempView1 addSubview:titleLabel1];
    
    UITextField *_textField = [UITextField new];
    _textField.frame = CGRectMake(CGRectGetMaxX(titleLabel1.frame)+2, 13,self.viewWidth-135, 30);
    _textField.textColor = kFontColor_Contacts;
    _textField.font = [UIFont fontWithName:kFontName size:14];
    _textField.placeholder = [NSString stringWithFormat:@"请输入%@",title];
    [tempView1 addSubview:_textField];
    
    *textField = _textField;
    
    return tempView1;
}

- (void)updateInfo:(id)obj withRefreshSupperView:(TreatmentRefreshSupperViewBLock)block{
    self.block = block;
}


@end
