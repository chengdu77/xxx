//
//  NextCaseHistoryViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "NextCaseHistoryViewController.h"
#import "IQTextView.h"
#import "MyPhotographViewController.h"

@interface NextCaseHistoryViewController (){
    IQTextView *textView;
    
    UIView *images;
    UIImage *defaultImage;
    NSMutableArray *imageArray;
    NSMutableArray *imageFiles;
    
    NSDictionary *previouData;
}

@end

@implementation NextCaseHistoryViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    self.title = @"新建病历";
    
    
    imageArray = [NSMutableArray array];
    defaultImage = [UIImage imageNamed:@"addphoto"];
    [imageArray addObject:defaultImage];
    imageFiles = [NSMutableArray array];
    
    [self initNextView];
    [self uploadImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)initNextView{
    
    CGRect frame = CGRectMake(0,0,self.viewWidth, 40);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.text = @"   完善病历信息";
    titleLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [self.scrollView addSubview:titleLabel];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame),self.viewWidth,230);
    UIView *doctorView = [UIView new];
    doctorView.backgroundColor = [UIColor whiteColor];
    doctorView.frame = frame;
    [self.scrollView addSubview:doctorView];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.viewWidth,40)];
    tempLabel.text = @"   医嘱";
    tempLabel.font = [UIFont fontWithName:kFontName size:16.0];
    [doctorView addSubview:tempLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(tempLabel.frame),self.viewWidth-20,1)];
    lineLabel.backgroundColor = kBackgroundColor;
    [doctorView addSubview:lineLabel];
    
    textView = [[IQTextView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(lineLabel.frame),self.viewWidth-20,179)];
    textView.placeholder = @"医生诊断，如疾病名称等，必填";
    [doctorView addSubview:textView];
    
    frame = CGRectMake(0,CGRectGetMaxY(frame)+5,self.viewWidth,126);
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
    
    frame = CGRectMake(10,CGRectGetMaxY(frame)+20,self.viewWidth -20,40);
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    completeButton.frame = frame;
    completeButton.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    completeButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [completeButton setTitle:@"完  成" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeButton setBackgroundColor:kALL_COLOR];
    [completeButton addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:completeButton];
    
    self.scrollView.contentSize = CGSizeMake(self.viewWidth,CGRectGetMaxY(frame)+5);
}

- (void)uploadImages{
    
    for (UIView *view in images.subviews) {
        [view removeFromSuperview];
    }
    CGFloat f = (self.viewWidth - kImageSize*kImageNumber)/(kImageNumber+1);
    
    for (int i=0;i<imageArray.count;i++){
        CGRect frame = CGRectMake(i*kImageSize+f*(i+1),0,kImageSize,kImageSize);
        UIImageView *imageView = [[UIImageView  alloc] initWithFrame:frame];
        imageView.image = imageArray[i];
        [images addSubview:imageView];
        imageView.tag = 1000+i;
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewAction:)];
        [imageView addGestureRecognizer:viewTapGesture];
    
    }
}

- (void)imageViewAction:(UITapGestureRecognizer *)sender{
    UIImageView *imageView = (UIImageView *)sender.view;
    if ([imageView.image isEqual:defaultImage]) {
        [[MyPhotographViewController shareInstance] viewController:self withBlock:^(UIImage *image) {
            
            [imageArray insertObject:image atIndex:imageArray.count-1];
            [self uploadImages];
            [self addDeleteView];
            
            NSDate *now = [NSDate new];
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *fileName = [NSString stringWithFormat:@"BL_%@",[formatter stringFromDate:now]];
            
            //           UIImage *theImage = [self imageByScalingToMaxSize:image];
            
            UploadImageParam *uploadParam = [UploadImageParam new];
            uploadParam.data =  UIImageJPEGRepresentation(image, 0.5);
            uploadParam.name = @"file";
            uploadParam.filename = fileName;
            uploadParam.mimeType = @"image/png";
            
            [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
            [ContactsRequest tokenUploadRequestParameters:nil uploadParam:uploadParam success:^(PiblicHttpResponse *response) {
                [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
                
                NSDictionary *info = response.message;
                NSString *path = info[@"path"];
                if (path.length >0) {
                    
                    [imageArray insertObject:image atIndex:imageArray.count-1];
                    [imageFiles addObject:path];
                    [self uploadImages];
                    [self addDeleteView];
                }
                
            } fail:^(BOOL notReachable, NSString *desciption) {
                [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
                [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
            }];
            
        }];
        
        return;
    }
}

- (void)addDeleteView {
    
    UIButton *deleteButton = nil;
    for (UIImageView *tempView in images.subviews) {
        if ([tempView isKindOfClass:[UIImageView class]]) {
            if ([tempView.image isEqual:defaultImage]) {
                continue;
            }
            deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(tempView.frame.size.width-20,0,20, 20)];
            [deleteButton setImage:[UIImage imageNamed:@"case_delete.png"] forState:UIControlStateNormal];
            deleteButton.imageView.tag = tempView.tag;
            deleteButton.tag = tempView.tag;
            [deleteButton addTarget:self action:@selector(deleteImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [tempView addSubview:deleteButton];
        }
    }
}

- (void)deleteImageAction:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    [imageArray removeObjectAtIndex:index];
    [self uploadImages];
}

- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block{
    self.block = block;
    
    previouData = obj;
}

- (void)completeAction:(UIButton *)sender{
    
    NSString *doctor_advice = textView.text;
    if (doctor_advice.length == 0) {
        [MBProgressHUD showError:@"请输入医嘱" toView:ShareAppDelegate.window];
        return;
    }
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:previouData];
    [data setObject:doctor_advice forKey:@"doctor_advice"];
    if (imageFiles.count >0) {
        NSString *path = [imageFiles componentsJoinedByString:@","];
        [data setObject:path forKey:@"path"];
    }
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    [ContactsRequest patientAddRecordRequestParameters:data success:^(PiblicHttpResponse *response) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        NSString *tip = response.message[@"tip"];
        if ([tip isEqualToString:@"成功"]) {
            [self backAction];
            self.block(nil);
        }
        
    } fail:^(BOOL notReachable, NSString *desciption) {
        [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
        [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
    }];
}


@end
