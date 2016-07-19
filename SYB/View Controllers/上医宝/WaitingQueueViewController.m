//
//  WaitingQueueViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/24.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "WaitingQueueViewController.h"
#import "UAProgressView.h"

#define kProgressLength 60.0f

@interface WaitingQueueViewController (){
    UILabel *titleLabel;
    UILabel *patientLabel;
}


@property (nonatomic, strong) UAProgressView *progressView;

@property (nonatomic, assign) CGFloat localProgress;
@end

@implementation WaitingQueueViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initThisView{
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    CGRect frame = CGRectMake(0,20,self.viewWidth,20);
    titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.text = @"儿科  邢爱云医生诊室叫号";
    titleLabel.font = [UIFont fontWithName:kFontName size:16];
    titleLabel.textColor = kFontColor_Contacts;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:titleLabel];
    
    frame = CGRectMake((self.viewWidth -160)/2,CGRectGetMaxY(frame)+20,160,160);
    self.progressView = [[UAProgressView alloc] initWithFrame:frame];
    [self.scrollView addSubview:self.progressView];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+20,self.viewWidth,20);
    patientLabel = [[UILabel alloc] initWithFrame:frame];
    patientLabel.text = @"就诊人 韩梅梅";
    patientLabel.font = [UIFont fontWithName:kFontName size:16];
    patientLabel.textColor = kFontColor_Contacts;
    patientLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:patientLabel];

    self.progressView.tintColor = RGB(244, 166, 146);
    self.progressView.borderWidth = 4.0;
    self.progressView.fillOnTouch = NO;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.0, 32.0)];
    textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:32];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = self.progressView.tintColor;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.text = @"0";
    self.progressView.centralView = textLabel;
    
    self.progressView.progressChangedBlock = ^(UAProgressView *progressView, CGFloat progress){
        [(UILabel *)progressView.centralView setText:[NSString stringWithFormat:@"%2.0f", progress * kProgressLength]];
    };self.progressView.progress = 0;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
}

- (void)updateProgress:(NSTimer *)timer {
    _localProgress = ((int)((_localProgress * kProgressLength) + 1.01) % (int)kProgressLength) / kProgressLength;
    [self.progressView setProgress:_localProgress];
}


@end
