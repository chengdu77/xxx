//
//  ExpertDetailsViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ExpertDetailsViewController.h"
#import "UIView+BindValues.h"
#import "PullingRefreshTableView.h"
#import "AppointmentViewController.h"
#import "ChatMainViewController.h"
#import "AppraisalTableViewCell.h"
#import "JCProgressView.h"

@interface ExpertDetailsViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
    UIScrollView *footScrollView;
    NSMutableArray *scrollViewsArray;
    UISegmentedControl *segmentedControl;
    
    PullingRefreshTableView *_tableView;
    
    NSMutableArray *appraisalArray;//评论数据
    NSInteger pageNumber;
}

@end

@implementation ExpertDetailsViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    pageNumber = 1;
    
    NSDictionary *info = @{@"userName":@"秦梦艺",@"time":@"06-17",@"detail":@"泸州，四川省地级市，古称“江阳”，别称酒城、江城。位于四川省东南部，长江和沱江交汇处，川滇黔渝结合部区域中心城市。2014年，泸州城镇化率达45.1%，中心城区建成区面积达113.17平方公里、人口达111.59万人。",@"count":@(5),@"CellHeight":@(96)};
    
    appraisalArray = [NSMutableArray array];
    [appraisalArray addObject:info];
    
    info = @{@"userName":@"杨骏错",@"time":@"06-17",@"detail":@"泸州，四川省地级市，古称“江阳”，别称酒城、江城。",@"count":@(3),@"CellHeight":@(96)};
    [appraisalArray addObject:info];
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 170);
    UIView *headView = [[UIView alloc] initWithFrame:frame];
    //背景图片
    UIImageView *customBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doctordetailsback"]];
    [headView addSubview:customBackground];
    [headView sendSubviewToBack:customBackground];
    //返回按钮
    UIButton *_btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBack.frame = CGRectMake(25, 10, 65, 35);
    [_btnBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_btnBack setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [headView addSubview:_btnBack];
    
    UIImageView *score2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"score2"]];
    score2.frame = CGRectMake(self.viewWidth-30,15, 24, 24);
    [headView addSubview:score2];
    
    //人员头像
    UIImageView *txImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_icon"]];
    txImageView.frame = CGRectMake((self.viewWidth-50)/2, 10, 50, 50);
    [headView addSubview:txImageView];
    [self roundImageView:txImageView withColor:[UIColor whiteColor]];
    
// 人员名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(txImageView.frame)+5,self.viewWidth, 20)];
    nameLabel.text = @"郭应强";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont fontWithName:kFontName size:16.0];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:nameLabel];
    
    UILabel *dept_jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(nameLabel.frame)+5,self.viewWidth, 20)];
    dept_jobLabel.text = @"心血管外科  主任医师";
    dept_jobLabel.textColor = [UIColor whiteColor];
    dept_jobLabel.font = [UIFont fontWithName:kFontName size:14.0];
    dept_jobLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:dept_jobLabel];
    
    NSArray *segmentedData = @[@"简介",@"预约",@"咨询",@"评价"];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(0,CGRectGetHeight(frame) - 35.0,self.viewWidth, 35.0);
    [headView addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 1;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateHighlighted];
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self.scrollView addSubview:headView];
    
    
    CGRect rect = CGRectOffset(headView.frame, 0, headView.frame.size.height);
    rect.size.height = self.viewHeight - CGRectGetHeight(frame);
    footScrollView = [[UIScrollView alloc] initWithFrame:rect];
    [self.scrollView addSubview:footScrollView];
    
    footScrollView.backgroundColor = [UIColor clearColor];
    footScrollView.showsHorizontalScrollIndicator = NO;
    footScrollView.showsVerticalScrollIndicator = YES;
    footScrollView.pagingEnabled=YES;
    footScrollView.bounces = NO;
    footScrollView.delegate = self;
    
    scrollViewsArray = [NSMutableArray array];
    for (NSInteger i=0;i <segmentedData.count;i++){
        UIView *view;
        if (i==0) {
            view = [self jjViewWithFrame:rect tag:i];
        }
        
        if (i==1) {
            view = [self yyViewWithFrame:rect tag:i];
        }
        
        if (i==2) {
            view = [self zxViewWithFrame:rect tag:i];
        }
        
        if (i==3) {
            view = [self pjViewWithFrame:rect tag:i];
        }
        
        CGRect r = view.bounds;
        r.origin.x = i*self.viewWidth;
        r.origin.y = 0;
        view.frame = r;
        [footScrollView addSubview:view];
        [scrollViewsArray addObject:view];
        
    }
    
    footScrollView.contentSize = CGSizeMake(self.viewWidth * segmentedData.count, rect.size.height);
    
    [footScrollView setContentOffset:CGPointMake(segmentedControl.selectedSegmentIndex * self.viewWidth, 0) animated:YES];

}

#pragma mark 简介View
- (UIView *)jjViewWithFrame:(CGRect)frame tag:(NSUInteger)index{
    
    CGRect rect = CGRectMake(0,10,frame.size.width,frame.size.height);
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    view.tag = index;
    
    NSString *detail = @"人生若只如初见，何事秋风悲画扇。\n等闲变却故人心，却道故人心易变。\n骊山语罢清宵半，泪雨霖铃终不怨。\n何如薄幸锦衣郎，比翼连枝当日愿。";
    
    UIView *titleView = [self jjListViewWithFrame:rect title:@"擅长" detail:detail];
    [view addSubview:titleView];
    CGRect tFrame = titleView.frame;
    rect = CGRectMake(0,CGRectGetMaxY(tFrame)+10,frame.size.width,frame.size.height);
    
    UIView *schedulingView = [self schedulingViewWithFrame:rect title:@"排班情况" detail:@""];
    [view addSubview:schedulingView];
    tFrame = schedulingView.frame;
    
    rect = CGRectMake(0,CGRectGetMaxY(tFrame)+10,frame.size.width,frame.size.height);
    detail = @"据史料记载，泸州，上古至秦朝时属于巴国。专家考证，巴人(包括泸州人)曾参加周武王伐纣，建立奇功，得到封赏。其中尹吉甫是辅佐周宣王的重臣。作为全球尹氏华人公认的先祖第一人尹吉甫，是《诗经》的作者之一，也是古江阳人。汉初毛公著《毛诗故训传》训释诗经及西汉扬雄(前53——后18)著《琴清音》时，对其均有所言载。据明嘉靖十三年甲午(一五三四年)雷洁撰《重修周卿士尹吉甫庙记》曰：尹吉甫者，江阳人。”中华书局2002年版《平遥古城志》第248页亦载：“尹吉甫(生淬年不详)，即兮伯吉父。兮氏，名甲，字伯吉父(一作甫)，尹是官名。古蜀国江阳(今四川省泸州市龙马潭区石洞镇)人矣。\n        夏、商时期，泸州为“梁州之域”，至周代则属“巴子之地”。正所谓“清酒之美，始于耒耜”，巴蜀出产“巴乡清”酒，曾是向周王朝交纳的贡品，江阳人尹吉甫在《诗经-大雅》中曾云：“显父浅之，清酒百壶。”而北魏地理学家、散文家郦道元在所撰地理名著《水经注》卷33《江水(一)》中记述江阳县时有云：“有巴人村，村人善酿，故俗称巴乡清，郡出名酒。”可见，巴乡清酒，无论从地域上，还是与泸州人尹吉甫的诗文记载。";
    
    UIView *introductionView = [self jjListViewWithFrame:rect title:@"简介" detail:detail];
    [view addSubview:introductionView];
    tFrame = introductionView.frame;
    
    
    rect = CGRectMake(0,CGRectGetMaxY(tFrame)+10,frame.size.width,frame.size.height);
    detail = @"成都中医药大学";
    
    UIView *shcoolView = [self jjListViewWithFrame:rect title:@"毕业学校" detail:detail];
    [view addSubview:shcoolView];
    tFrame = shcoolView.frame;
    
    view.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(tFrame)+5);
    
    return view;
}

#pragma mark 简介子列表
- (UIView *)jjListViewWithFrame:(CGRect)frame title:(NSString *)title detail:(NSString *)detail{
    
    CGRect rect = CGRectMake(0,0,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,17,8,8)];
    dotImageView.image = [UIImage imageNamed:@"reg_circle"];
    [view addSubview:dotImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,10,100,20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    titleLabel.textColor = kFontColor_Contacts;
    [view addSubview:titleLabel];
    
    CGRect r = CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth - (CGRectGetMaxX(dotImageView.frame)+8)*2, 0);
    
    UILabel *detailLabel = [self adaptiveLabelWithFrame:r detail:detail fontSize:14];
    [view addSubview:detailLabel];
    
    CGFloat height = detailLabel.frame.size.height;
    frame.size.height = height+45;
    view.frame = frame;
    
    return view;
}
#pragma mark 简介排班时间表
- (UIView *)schedulingViewWithFrame:(CGRect)frame title:(NSString *)title detail:(NSString *)detail{
    
    CGRect rect = CGRectMake(0,0,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *dotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,17,8,8)];
    dotImageView.image = [UIImage imageNamed:@"reg_circle"];
    [view addSubview:dotImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dotImageView.frame)+8,10,100,20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    titleLabel.textColor = kFontColor_Contacts;
    [view addSubview:titleLabel];
    
    NSArray *info1 = @[@"",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSArray *fill1 = @[@(0),@(0),@(0),@(0),@(0),@(0),@(0),@(0)];
    UIView *view1 = [self timeViewWithFrame:CGRectMake(0,CGRectGetMaxY(titleLabel.frame)+5,self.viewWidth,30) info:info1 fill:fill1 online:YES];
    [view addSubview:view1];
    
    NSArray *info2 = @[@"上午",@"",@"7点",@"",@"",@"",@"7点",@""];
    NSArray *fill2 = @[@(0),@(0),@(1),@(0),@(0),@(0),@(1),@(0)];
    UIView *view2 = [self timeViewWithFrame:CGRectMake(0,CGRectGetMaxY(view1.frame),self.viewWidth,30) info:info2 fill:fill2 online:NO];
    [view addSubview:view2];
    
    NSArray *info3 = @[@"下午",@"",@"1点",@"1点",@"1点",@"",@"",@""];
    NSArray *fill3 = @[@(0),@(0),@(1),@(1),@(1),@(0),@(0),@(0)];
    UIView *view3 = [self timeViewWithFrame:CGRectMake(0,CGRectGetMaxY(view2.frame),self.viewWidth,30) info:info3 fill:fill3 online:YES];
    [view addSubview:view3];
    
    frame.size.height = 135;
    view.frame = frame;
    
    return view;
}

- (UIView *)timeViewWithFrame:(CGRect)frame info:(NSArray *)info fill:(NSArray *)fill online:(BOOL)online{
    CGRect rect = CGRectMake(0,frame.origin.y,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    
    if (online) {
        view.layer.borderColor = kALL_COLOR.CGColor;
        view.layer.borderWidth = .5;
    }
    CGFloat width = self.viewWidth/8.0;
    
    for ( NSInteger j = 0;j < info.count;j++){
        NSString *title = info[j];
        BOOL isFill = [fill[j] boolValue];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j*width,0,width,CGRectGetHeight(frame))];
        label.text = title;
        label.font = [UIFont fontWithName:kFontName size:14];
        label.textColor = kFontColor_Contacts;
        label.textAlignment = NSTextAlignmentCenter;
        if (isFill) {
            label.backgroundColor = kALL_COLOR;
        }
        
        [view addSubview:label];
    }
    
    return view;
}

#pragma mark 预约View
- (UIView *)yyViewWithFrame:(CGRect)frame tag:(NSUInteger)index{
    
    CGRect rect = CGRectMake(0,0,frame.size.width,frame.size.height);
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:rect];
    view.backgroundColor = kBackgroundColor;
    view.tag = index;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,30)];
    titleLabel.text = @"  预约规则:每天14点更新";
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
//    titleLabel.textColor = kFontColor;
    [view addSubview:titleLabel];
    
    int h = 5;//控制行间距
    CGRect tFrame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+1,self.viewWidth,66);
    for (int i=0;i<8;i++) {
        UIView *tempView = [self yyListViewWithFrame:tFrame tag:i];
        [view addSubview:tempView];
        if (i < 7) {
            tFrame = CGRectMake(0, CGRectGetMaxY(tFrame)+h,self.viewWidth,66);
        }
    }
    
    view.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(tFrame)+25);

    return view;
}
#pragma mark 预约列表
- (UIView *)yyListViewWithFrame:(CGRect)frame tag:(NSUInteger)index{
   
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10,150,20)];
    timeLabel.text = @"2016-06-15 周三 下午";
    timeLabel.font = [UIFont fontWithName:kFontName size:14];
//    timeLabel.textColor = kFontColor;
    [view addSubview:timeLabel];
    
    UILabel *costLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(timeLabel.frame)+5,150,20)];
    costLabel.text = @"专家门诊 15.00元";
    costLabel.font = [UIFont fontWithName:kFontName size:14];
    costLabel.textColor = RGB(244, 166, 146);
    [view addSubview:costLabel];
    
    CGRect tFrame =CGRectMake(self.viewWidth-80,(frame.size.height - 26)/2-5,60,26);
    UIButton *yyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yyButton.frame = tFrame;
    yyButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    yyButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [yyButton setTitle:@"预约" forState:UIControlStateNormal];
    [yyButton setTitleColor:kALL_COLOR forState:UIControlStateNormal];
    [yyButton setBackgroundColor:[UIColor whiteColor]];
    [yyButton addTarget:self action:@selector(yyAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:yyButton];
    yyButton.layer.borderColor = kALL_COLOR.CGColor;
    yyButton.layer.borderWidth = .5;
    yyButton.layer.cornerRadius = 5;
    yyButton.tag = 2000;
    
    UILabel *votesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.viewWidth-80,CGRectGetMaxY(tFrame)+2,60,20)];
    votesLabel.text = @"剩余:200";
    votesLabel.font = [UIFont fontWithName:kFontName size:14];
    votesLabel.textColor = kFontColor;
    votesLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:votesLabel];
    
    return view;
}

#pragma mark 咨询View
- (UIView *)zxViewWithFrame:(CGRect)frame tag:(NSUInteger)index{
    
    CGRect rect = CGRectMake(0,0,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
    view.tag = index;
    
    UIView *onlineView = [[UIView alloc] initWithFrame:CGRectMake(0,10,self.viewWidth,100)];
    onlineView.backgroundColor = [UIColor whiteColor];
    [view addSubview:onlineView];
    onlineView.userInteractionEnabled = YES;
    UITapGestureRecognizer *onlineViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onlineViewClicked:)];
    [onlineView addGestureRecognizer:onlineViewTapGesture];
    
    UIImageView *onlineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,80,80)];
    onlineImageView.image = [UIImage imageNamed:@"online"];
    [onlineView addSubview:onlineImageView];
    
    UILabel *onlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(onlineImageView.frame)+5,25,100,20)];
    onlineLabel.text = @"在线咨询";
    onlineLabel.font = [UIFont fontWithName:kFontName size:17];
//    onlineLabel.textColor = kFontColor;
    [onlineView addSubview:onlineLabel];
    
    UILabel *onlineDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(onlineImageView.frame)+5,CGRectGetMaxY(onlineLabel.frame)+5,220,20)];
    onlineDesLabel.text = @"发送文字、图片与医生在线交流";
    onlineDesLabel.font = [UIFont fontWithName:kFontName size:14];
    onlineDesLabel.textColor = kFontColor;
    [onlineView addSubview:onlineDesLabel];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(onlineView.frame)+10,self.viewWidth,100)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [view addSubview:phoneView];
    phoneView.userInteractionEnabled = YES;
    UITapGestureRecognizer *phoneViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneViewClicked:)];
    [phoneView addGestureRecognizer:phoneViewTapGesture];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15,10,80,80)];
    phoneImageView.image = [UIImage imageNamed:@"telephone"];
    [phoneView addSubview:phoneImageView];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(onlineImageView.frame)+5,25,100,20)];
    phoneLabel.text = @"电话咨询";
    phoneLabel.font = [UIFont fontWithName:kFontName size:17];
//    phoneLabel.textColor = kFontColor;
    [phoneView addSubview:phoneLabel];
    
    UILabel *phoneDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(onlineImageView.frame)+5,CGRectGetMaxY(onlineLabel.frame)+5,150,20)];
    phoneDesLabel.text = @"通过电话向医生咨询";
    phoneDesLabel.font = [UIFont fontWithName:kFontName size:14];
    phoneDesLabel.textColor = kFontColor;
    [phoneView addSubview:phoneDesLabel];
    
    return view;
}

#pragma mark 评价View
- (UIView *)pjViewWithFrame:(CGRect)frame tag:(NSUInteger)index{
    
    CGRect rect = CGRectMake(0,0,frame.size.width,frame.size.height);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.tag = index;

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,44)];
    [view addSubview:headView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,0,80,44)];
    titleLabel.font = [UIFont fontWithName:kFontName size:14];
    titleLabel.textColor = RGB(244, 166, 146);
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"满意度75%\n共20条评论";
    [headView addSubview:titleLabel];
    
    JCProgressView *progressView = [[JCProgressView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+5,12,self.viewWidth - 100,20)];
    progressView.progress = 0.9;
    progressView.fillColor = RGB(244, 166, 146);
    [headView addSubview:progressView];

    
    _tableView = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.frame)+5,self.viewWidth,self.viewHeight - CGRectGetMaxY(headView.frame)) pullingDelegate:self];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib *nib=[UINib nibWithNibName:@"AppraisalTableViewCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"AppraisalTableViewCell"];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self reloadData];
    
    [view addSubview:_tableView];
    
    return view;
}

#pragma mark -- talbeView的代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return appraisalArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *info = appraisalArray[indexPath.row];
    return [info[@"CellHeight"] integerValue];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tableViewIdentifier = @"AppraisalTableViewCell";
    
    AppraisalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (cell == nil) {
        cell = [[AppraisalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewIdentifier];
    }
    
    NSDictionary *info = appraisalArray[indexPath.row];
    cell.userNameLabel.text = info[@"userName"];
    cell.userNameLabel.textColor = kFontColor_Contacts;
    
    CGRect oldRect = cell.detailLabel.frame;
    [cell.detailLabel removeFromSuperview];
    UILabel *detailLabel = [self adaptiveLabelWithFrame:oldRect detail:info[@"detail"] fontSize:12];
    [cell addSubview:detailLabel];
    
    CGFloat differHeight = CGRectGetHeight(detailLabel.frame) - CGRectGetHeight(oldRect);
    
    cell.timeLabel.text = info[@"time"];
    cell.timeLabel.textColor = kALL_COLOR;
    
    NSInteger count = [info[@"count"] integerValue];
    if (count >0) {
        CGRect rect = cell.appraisal_back_ImageView.frame;
        rect.size.width *= count/5.0;
        
        UIImage *image = [UIImage imageNamed:@"appraisal_front"];
        CGSize size = image.size;
        size.width *= count/5.0;
        
        CGRect frame = CGRectZero;
        frame.size = size;
        CGImageRef imageRef = image.CGImage;
        CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef,frame);
        UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
        CGImageRelease(imagePartRef);
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:cropImage];
        imageView.frame = rect;
        [cell addSubview:imageView];
    }
    
    CGRect frame = cell.bubbleImageView.frame;
    frame.size.height += differHeight+5;
    [cell.bubbleImageView removeFromSuperview];
    
    UIImage *image = [UIImage imageNamed:@"chatfrom_bg"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:image];
    bubbleImageView.frame = frame;
    [cell addSubview:bubbleImageView];
    [cell sendSubviewToBack:bubbleImageView];
    cell.bubbleImageView.image = image;
    
//    [self makeMaskView:cell.bubbleImageView withImage:image];
    
    frame = cell.frame;
    frame.size.height += differHeight +5;
     cell.frame = frame;
    
    CGFloat oldHeight = [info[@"CellHeight"] floatValue];
    if (frame.size.height > oldHeight) {
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:info];
        [data setObject:@(frame.size.height) forKey:@"CellHeight"];
        [appraisalArray replaceObjectAtIndex:indexPath.row withObject:data];
    }

    return cell;
}

- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image
{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    pageNumber++;
    [self reloadDataWithPageNumber:pageNumber];;
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *currentDateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:currentDateStr];
    return date;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    pageNumber++;
    [self reloadDataWithPageNumber:pageNumber];
}

- (void)reloadData{
    
    [_tableView reloadData];
    [_tableView tableViewDidFinishedLoading];
    _tableView.reachedTheEnd = NO;
    
}

- (void)reloadDataWithPageNumber:(NSInteger)pageNum{
    
}


//拖拽后调用的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if ([scrollView isEqual:footScrollView]) {
        return;
    }
    
    [_tableView tableViewDidEndDragging:scrollView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:footScrollView]) {
        return;
    }
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:footScrollView]) {
        return;
    }
    
    [_tableView tableViewDidScroll:scrollView];
}

#pragma mark 左右滑动时，
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:footScrollView]) {
        for (UIView *view in scrollViewsArray) {
            if (CGRectContainsPoint(view.frame,footScrollView.contentOffset)) {
                segmentedControl.selectedSegmentIndex = view.tag;
                break;
            }
        }
    }
}


-(void)doSomethingInSegment:(UISegmentedControl *)seg{
    
    NSInteger index = seg.selectedSegmentIndex;
    
    [footScrollView setContentOffset:CGPointMake(index * self.viewWidth, 0) animated:YES];
}

#pragma mark 点击预约按钮
- (void)yyAction:(UIButton *)sender{
    
    AppointmentViewController *appointmentViewController = AppointmentViewController.new;
    appointmentViewController.title = @"预约挂号";
    
   [self.navigationController pushViewController:appointmentViewController animated:YES];
    
}

#pragma mark 点击在线咨询
- (void)onlineViewClicked:(UITapGestureRecognizer *)sender{
    
    ChatMainViewController *chatMainViewController = [[ChatMainViewController alloc] initWithNibName:@"ChatMainViewController" bundle:nil];
    chatMainViewController.title = @"咨询详情";
    [self.navigationController pushViewController:chatMainViewController animated:YES];
    
}

#pragma mark 点击电话咨询
- (void)phoneViewClicked:(UITapGestureRecognizer *)sender{
    
}


@end
