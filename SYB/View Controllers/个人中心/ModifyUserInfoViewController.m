//
//  ModifyUserInfoViewController.m
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ModifyUserInfoViewController.h"
#import "MyPhotographViewController.h"
#import "ModifypasswordViewController.h"

#define kTXImageViewTag 200

@interface ModifyUserInfoViewController ()


@property (nonatomic,strong) UIImageView *txImageView;

@end

@implementation ModifyUserInfoViewController

- (void)viewDidLoad {
    self.hasBackWardFlag = YES;
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self initThisView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)initThisView{
    
    CGRect frame = CGRectMake(0, 0,self.viewWidth, 80);
    //-----头像部分-----//
    UIView *txView = [[UIView alloc] initWithFrame:frame];
    txView.backgroundColor = [UIColor whiteColor];
    self.txImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.viewWidth-55)/2, (80-55)/2,55, 55)];
    self.txImageView.image = [UIImage imageNamed:@"image_icon"];
    [txView addSubview:self.txImageView];
    
    self.txImageView.tag = kTXImageViewTag;
    self.txImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *txImageDtapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTXImageView)];
    [self.txImageView addGestureRecognizer:txImageDtapGesture];
    
    [self.scrollView addSubview:txView];
    
    frame = CGRectMake(0, CGRectGetMaxY(frame)+5,self.viewWidth, 56);
    UIView *passwdView = [self drawListView:frame title:@"密码" image:[UIImage imageNamed:@"icon_PassWord"] action:@selector(midifyPasswordAction) tag:1];
    [self.scrollView addSubview:passwdView];
    
//    if (self.txImage==nil) {
//        [self roundImageView:self.txImageView withColor:nil];
//        [self setImageWithURL:self.bean.icon imageView:self.txImageView placeholderImage:[UIImage imageNamed:@"我的部门"]];
//        
//    }else{
//        self.txImageView.image = self.txImage;
//        [self roundImageView:self.txImageView withColor:nil];
//    }
//    
//    if (self.editableImageFlag) {
//        
//        self.txImageView.tag = kTXImageViewTag;
//        self.txImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *txImageDtapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTXImageView)];
//        [self.txImageView addGestureRecognizer:txImageDtapGesture];
//    }
    
}

- (UIView *)drawListView:(CGRect)frame title:(NSString *)title image:(UIImage *)image action:(nullable SEL)action tag:(NSUInteger) tag{
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = frame;
    view.tag = tag;
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(15, (56-25)/2,25, 25);
    imageView.image = image;
    [view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(48, 8,150, 40);
    label.text = title;
    label.textColor = kFontColor_Contacts;
    label.font = [UIFont fontWithName:kFontName size:14];
    [view addSubview:label];
    
    UIImageView *jtImageView = [UIImageView new];
    jtImageView.frame = CGRectMake(self.viewWidth-40, 13,30, 30);
    jtImageView.image = [UIImage imageNamed:@"箭头"];
    [view addSubview:jtImageView];
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [view addGestureRecognizer:viewTapGesture];
    
    return view;
}


- (void)selectTXImageView{
    
    [[MyPhotographViewController shareInstance] viewController:self withBlock:^(UIImage *image) {
        
//        NSDate *now = [NSDate new];
//        NSDateFormatter *formatter = [NSDateFormatter new];
//        [formatter setDateFormat:@"yyyyMMddHHmmss"];
//        NSString *fileName = [NSString stringWithFormat:@"IMG_%@",[formatter stringFromDate:now]];
        
        UIImage *theImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(kTXImageViewWidth,kTXImageViewWidth)];
        
        self.txImageView.image = theImage;
        [self roundImageView:self.txImageView withColor:nil];
        
//        UploadImageParam *uploadParam = [UploadImageParam new];
//        uploadParam.data =  UIImagePNGRepresentation(theImage);
//        uploadParam.name = @"file";
//        uploadParam.filename = fileName;
//        uploadParam.mimeType = @"image/png";
//        
//        [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
//        [ContactsRequest tokenUploadRequestParameters:nil uploadParam:uploadParam success:^(PiblicHttpResponse *response) {
//            //            [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
//            
//            NSDictionary *info = response.message;
//            NSString *path = info[@"path"];
//            if (path.length >0) {
//                
//                UITextView *tempTextView = [self.scrollView viewWithTag:kTextViewTag];
//                NSString *desc = tempTextView.value;
//                NSString *mobile = [[NSUserDefaults standardUserDefaults] objectForKey:kUSERNAME];
//                NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"icon":path,@"mobile":mobile}];
//                
//                if (desc) {
//                    [userInfo setObject:@"des" forKey:desc];
//                }
//                [self userUpdateUser:userInfo image:image];
//            }
//            
//        } fail:^(BOOL notReachable, NSString *desciption) {
//            [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
//            [MBProgressHUD showError:desciption toView:ShareAppDelegate.window];
//        }];
        
    }];
}

- (void)midifyPasswordAction{
    
    ModifypasswordViewController *modifypasswordViewController = ModifypasswordViewController.new;
    [self.navigationController pushViewController:modifypasswordViewController animated:YES];
    
}

@end
