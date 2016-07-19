//
//  AddressViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "AddressViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


#import <MapKit/MapKit.h>


@interface MyPoint : NSObject <MKAnnotation>

//实现MKAnnotation协议必须要定义这个属性
@property (nonatomic,readonly) CLLocationCoordinate2D coordinate;
//标题
@property (nonatomic,copy) NSString *title;

//初始化方法
-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString*)t;

@end

@implementation MyPoint

-(id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)t{
    self = [super init];
    if(self){
        _coordinate = c;
        _title = t;
    }
    return self;
}

@end

@interface AddressViewController ()<MKMapViewDelegate>
//地图
@property (strong, nonatomic) MKMapView *mapView;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    
    [self initThisView];
    [self initLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UILabel *detialAddrLabel = [[UILabel alloc] initWithFrame:frame];
    detialAddrLabel.text = @"   详细地址";
    detialAddrLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:detialAddrLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 56);
    UILabel *detialAddrVLabel = [[UILabel alloc] initWithFrame:frame];
    detialAddrVLabel.text = @"   四川省成都市外南国学巷37号";
    detialAddrVLabel.font = [UIFont fontWithName:kFontName size:16.0];
    detialAddrVLabel.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:detialAddrVLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 40);
    UILabel *trafficLabel = [[UILabel alloc] initWithFrame:frame];
    trafficLabel.text = @"   交通";
    trafficLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:trafficLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 56);
    UILabel *trafficVLabel = [[UILabel alloc] initWithFrame:frame];
    trafficVLabel.text = @"   乘坐303、28、16、99、109、82、110路灯公交可达到";
    trafficVLabel.font = [UIFont fontWithName:kFontName size:14.0];
    trafficVLabel.numberOfLines = 2;
    trafficVLabel.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:trafficVLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth, 40);
    UILabel *mapLabel = [[UILabel alloc] initWithFrame:frame];
    mapLabel.text = @"   地图位置";
    mapLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:mapLabel];
    
    frame = CGRectMake(10,CGRectGetMaxY(frame),self.viewWidth-20,self.viewHeight - CGRectGetMaxY(frame)-75);
    self.mapView = [[MKMapView alloc] initWithFrame:frame];
    [self.scrollView addSubview:self.mapView];
    
    [self.mapView setZoomEnabled:NO];
    [self.mapView setScrollEnabled:NO];
//    [self.mapView setDelegate:self];
}

////MapView委托方法，当定位自身时调用
//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
//    CLLocationCoordinate2D loc = [userLocation coordinate];
//
//    
//    //放大地图到自身的经纬度位置。
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
//    [self.mapView setRegion:region animated:YES];
//}

//放置标注
- (void)initLocation {
    //创建CLLocation 设置经纬度30.6417633969,104.0613205889
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:30.6417633969 longitude:104.0613205889];
    CLLocationCoordinate2D coord = [loc coordinate];
    //创建标题
//    NSString *titile = [NSString stringWithFormat:@"%f,%f",coord.latitude,coord.longitude];
    NSString *titile = @"华西医院";
    
    MyPoint *myPoint = [[MyPoint alloc] initWithCoordinate:coord andTitle:titile];
    //添加标注
    [self.mapView addAnnotation:myPoint];
    
    //放大到标注的位置
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    [self.mapView setRegion:region animated:YES];
}



@end
