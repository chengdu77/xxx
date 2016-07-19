//
//  MedicallyMainViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/13.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MedicallyMainViewController.h"
#import "TPCPageScrollView.h"
#import "SearchViewController.h"
#import "UserCenterViewController.h"
#import "MedicallyCollectionViewCell.h"
#import "NewsView.h"
#import "MedicallyAppointmentViewController.h"
#import "CaseHistoryListViewController.h"
#import "AccessReportViewController.h"
#import "PaymentViewController.h"
#import "WaitingQueueViewController.h"

@interface MedicallyMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    TPCPageScrollView *pageScrollView;
    UICollectionView *collectionView;
    
    NSArray *entryData;
    
    NSArray *newsData;
    NSArray *newsIcon;
    NSInteger serialNumber;
    
    NSTimer *timer;

}

@property (weak, nonatomic) TPCPageScrollView *pageView;
@property (strong, nonatomic) NSArray *images;

@property (strong, nonatomic) NewsView *newsView;

@end

@implementation MedicallyMainViewController

- (void)viewDidLoad {
    self.hasTabBarFlag = YES;
    [super viewDidLoad];
    
    entryData = @[@{@"title":@"预约挂号",@"desc":@"提前预约 先人一步",@"icon":[UIImage imageNamed:@"jyb_main_reg"]},
                  @{@"title":@"排队候诊",@"desc":@"实时查看 门诊信息",@"icon":[UIImage imageNamed:@"jyb_main_call"]},
                  @{@"title":@"取报告单",@"desc":@"及时查看 检查报告",@"icon":[UIImage imageNamed:@"jyb_main_word"]},
                  @{@"title":@"查处方单",@"desc":@"随时随地 病历管理",@"icon":[UIImage imageNamed:@"jyb_main_manager"]},
                  @{@"title":@"支付结算",@"desc":@"快捷支付 不用排队",@"icon":[UIImage imageNamed:@"jyb_main_pay"]}
                  ];
    
    [self initPageScrollView];
    [self initThisView];
    [self initCollectionView];
    
    [self initNewsView];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [timer invalidate];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self execTimer];
}

- (void)initNewsView{
    
    CGRect tabFrame = self.tabBarController.tabBar.frame;
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0,self.viewHeight - CGRectGetHeight(tabFrame)-32,self.viewWidth,32)];
    [self.view addSubview:tempView];
    tempView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4,8,16,16)];
    imageView.image = [UIImage imageNamed:@"dynamic_red"];
    [tempView addSubview:imageView];
    
    _newsView = [[NewsView alloc] initWithFrame:CGRectMake(24,0,self.viewWidth-24,32)];
    [tempView addSubview:_newsView];
    
    newsData = @[@"TESTDESCRIPTION",@"阿斯顿的法国队",@"是电饭锅阿萨德",@"dfgdfgsf"];
    newsIcon = @[[UIImage imageNamed:@"image_icon"],[UIImage imageNamed:@"item_registration_select"],[UIImage imageNamed:@"call_eight"],[UIImage imageNamed:@"call_twentyone"]];
    
    serialNumber = 0;
    [_newsView setViewWithTitle:newsData[serialNumber]];
    [_newsView setViewWithIcon:newsIcon[serialNumber]];
    [UIView animateWithDuration:0.7 delay:0 options:0 animations:^(){
        _newsView.alpha = 0.2;
        [_newsView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
        _newsView.alpha = 1;
    } completion:^(BOOL finished){
        [self execTimer];
    }];
}

- (void)execTimer{
    
    if (timer) {
        timer = nil;
        [timer invalidate];
    }
    //设置定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(displayNews) userInfo:nil repeats:YES];
}

- (void)displayNews{
    
    serialNumber++;
    
    if (serialNumber >= [newsData count])
        serialNumber = 0;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f ;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeRemoved;
    animation.removedOnCompletion = YES;
    animation.type = @"cube";
    [_newsView.layer addAnimation:animation forKey:@"animationID"];
    
    [_newsView setViewWithTitle:newsData[serialNumber]];
    [_newsView setViewWithIcon:newsIcon[serialNumber]];
    
}

- (void)initThisView{
    CGRect frame = CGRectMake(0,0,self.viewWidth, 46);
    UIView *headView = [self searchViewWithFrame:frame];
    [self.scrollView addSubview:headView];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.view.bounds.size.width,156);
    pageScrollView.frame = frame;
}


#pragma mark 点击个人中心
- (void)userCenterClicked:(UITapGestureRecognizer *)sender{
    
    UserCenterViewController *userCenterViewController = UserCenterViewController.new;
    
    [self.navigationController pushViewController:userCenterViewController animated:YES];
    
}

#pragma mark 点击查询
- (void)searchClicked:(UITapGestureRecognizer *)sender{
    SearchViewController *searchViewController = SearchViewController.new;
    [self.navigationController pushViewController:searchViewController animated:YES];
}

- (void)initPageScrollView{
    pageScrollView = TPCPageScrollView.new;
    
    pageScrollView.pagingInterval = 5.0;
    [pageScrollView startAutoPaging];
    [self.scrollView addSubview:pageScrollView];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        AppDelegate *app = [UIApplication sharedApplication].delegate;
    pageScrollView.images = [self images];
    //        app.images = nil;
    //    });
    
    self.pageView = pageScrollView;
    self.pageView.currentPageColor = kRandomColor;
    self.pageView.otherPageColor = kRandomColor;
}


- (NSArray *)images{
    if (nil == _images) {
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
        
        for (int i = 0; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"tab%d.png", i+1];
            UIImage *image = [UIImage imageNamed:imageName];
            [images addObject:image];
        }
        self.images = images;
    }
    
    return _images;
}


- (void)initCollectionView{
    
    //1.初始化layout
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.viewWidth/2-9,70);
    layout.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6);
    //2.初始化collectionView
    CGRect frame = CGRectMake(0,CGRectGetMaxY(pageScrollView.frame),self.viewWidth,self.viewHeight - CGRectGetMaxY(pageScrollView.frame) -40);
    collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [self.scrollView addSubview:collectionView];
    collectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 MedicallyCollectionViewCell
    [collectionView registerClass:[MedicallyCollectionViewCell class] forCellWithReuseIdentifier:@"MedicallyCollectionViewCell"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
//    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MedicallyCollectionViewCell"];
    
    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
}

//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return entryData.count;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.viewWidth/2-9,70);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(6, 6, 6, 6);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)_collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MedicallyCollectionViewCell *cell = (MedicallyCollectionViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:@"MedicallyCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *data = entryData[indexPath.row];
    
    cell.titleLabel.text = data[@"title"];
    cell.descLabel.text = data[@"desc"];
    cell.imageView.image = data[@"icon"];
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger index = indexPath.row;
    HeadViewController * tempVC;
    switch (index) {
        case 0:{
            tempVC = MedicallyAppointmentViewController.new;
            break;
        }
        case 1:{
            tempVC = WaitingQueueViewController.new;
            break;
        }
        case 2:{
            tempVC = AccessReportViewController.new;
            break;
        }
        case 3:{
            tempVC = CaseHistoryListViewController.new;
            break;
        }
        case 4:{
            tempVC = PaymentViewController.new;
            break;
        }
    }
    
    NSDictionary *data = entryData[indexPath.row];
    tempVC.title = data[@"title"];
    [self.navigationController pushViewController:tempVC animated:YES];
}






@end
