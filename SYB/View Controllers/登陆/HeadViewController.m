//
//  HeadViewController.m
//  JCDB
//
//  Created by WangJincai on 16/1/1.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "HeadViewController.h"
#import "SIAlertView.h"
#import "Reachability.h"
#import "MyOperation.h"
#import <UIImageView+AFNetworking.h>

#define ORIGINAL_MAX_WIDTH 640.0f



@implementation MyScrollView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}
@end

@interface HeadViewController ()<UIGestureRecognizerDelegate>{
   
}


@end

@implementation HeadViewController

- (void)initSuperView {
    
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[MyScrollView alloc] init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.scrollView];
    
    self.viewWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.viewHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    self.iv_netstate = [UIView new];
    self.iv_netstate.frame = CGRectMake(0, 64, self.viewWidth, 40);
    
    _myUserName = [[NSUserDefaults standardUserDefaults] objectForKey:kUSERNAME];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(19,12,17,17)];
    imageView.image = [UIImage imageNamed:@"net_warn_icon"];
   
    [self.iv_netstate addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(46,10,232,21)];
    label.text = @"当前无网络，请检查设置";
    label.font = [UIFont systemFontOfSize:11.0];
    [self.iv_netstate addSubview:label];
    
    UIImageView *moreImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewWidth-20,14,10,15)];
    moreImageView.image = [UIImage imageNamed:@"setting_more"];
    [self.iv_netstate addSubview:moreImageView];
    
    self.iv_netstate.backgroundColor = RGB(250, 222, 164);
    [self.view addSubview:self.iv_netstate];
    [self.iv_netstate setHidden:YES];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNetworkAction:)];
    [self.iv_netstate addGestureRecognizer:tapGesture];
    
}

//根据title和区域大小画圆形，背景色为随机颜色
- (UIImage *)drawRoundWith:(NSString *)title size:(CGSize)size fillColor:(UIColor *)fillColor{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,size.width, size.height);
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    随机颜色
    UIColor *color = fillColor?fillColor:kRandomColor;

    button.titleLabel.font = [UIFont fontWithName:kFontName size:14];
    button.backgroundColor = color;
    button.layer.borderWidth = 1;
    button.layer.borderColor = color.CGColor;
    button.layer.cornerRadius = button.bounds.size.width/2;
    //    以下是形成图片快照
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    //从上下文中获取图片
    [button.layer renderInContext:ctx];
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

- (UIView *)searchViewWithFrame:(CGRect)frame{
    
    UIView *headView = [[UIView alloc] initWithFrame:frame];
    headView.backgroundColor = [UIColor clearColor];
    
    UIImageView *userCenterView = [[UIImageView alloc] initWithFrame:CGRectMake(13,8,30,30)];
    userCenterView.image = [UIImage imageNamed:@"top_tab_user_true"];
    userCenterView.userInteractionEnabled = YES;
    UITapGestureRecognizer *userCenterViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userCenterClicked:)];
    [userCenterView addGestureRecognizer:userCenterViewTapGesture];
    

    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(58,8,self.viewWidth-63, 30)];
    tmpView.backgroundColor = [UIColor whiteColor];
    tmpView.layer.cornerRadius = 4;
    [headView addSubview:tmpView];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3,5,20,20)];
    searchImageView.image = [UIImage imageNamed:@"top_tab_search_main_false"];
    [tmpView addSubview:searchImageView];
    
    UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(33,0,100,30)];
    [tmpView addSubview:searchLabel];
    searchLabel.text = @"搜索医生";
    searchLabel.font = [UIFont fontWithName:kFontName size:12.0];
    searchLabel.textColor = kFontColor;
    
    
    UIImageView *vImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(tmpView.frame)-25,5,20,20)];
    vImageView.image = [UIImage imageNamed:@"top_tab_search_recode_false"];
    [tmpView addSubview:vImageView];
    
    [headView addSubview:userCenterView];
    
    searchLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *headViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchClicked:)];
    [searchLabel addGestureRecognizer:headViewTapGesture];
    
    return headView;
}

//子类现实
- (void)userCenterClicked:(UITapGestureRecognizer *)sender{
    
}
//子类现实
- (void)searchClicked:(UITapGestureRecognizer *)sender{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    self.tabBarController.tabBar.backgroundColor = kTabColor;
    
    [self initSuperView];

    if (!self.hasTabBarFlag) {
        
        NSString *title = @" 返回";
        if (self.hasBackWardFlag) {
            title = @"";
        }
        UIButton * _btnBack = [self defaultBackButtonWithTitle:title];
        [_btnBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnBack setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        [_btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnBack];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
//    self.serviceIPInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kAddressHttps];

}

- (UIButton *)buttonForTitle:(NSString *)title action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:kALL_COLOR];
    [button setTitle:title forState:UIControlStateNormal];
    
    if (action) {
        [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

-(UIButton *)defaultBackButtonWithTitle:(NSString *)title{
    UIButton *button = [self defaultRightButtonWithTitle:title];
    return button;
}

-(UIButton *)defaultRightButtonWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 65, 35);
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    return btn;
}

-(void)showNetStateBar
{
    self.iv_netstate.hidden = NO;
    self.iv_netstate.layer.opacity = 0.0;
    CGRect rect = self.view.bounds;
    rect.size.height -= self.iv_netstate.frame.size.height;
    rect.origin.y += self.iv_netstate.frame.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        self.iv_netstate.layer.opacity = 1.0;
        _scrollView.frame = rect;
    }completion:^(BOOL finished) {
        [self.iv_netstate bringSubviewToFront:self.view];
    }];

}

-(void)hideNetStateBar{
    CGRect rect = self.view.bounds;
    [UIView animateWithDuration:0.5 animations:^{
        self.iv_netstate.layer.opacity = 0.0;
        _scrollView.frame = rect;
    } completion:^(BOOL finished) {
        self.iv_netstate.hidden = YES;
    }];
}

-(void)reachabilityChanged: (NSNotification* )note {
    Reachability* curReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            [self showNetStateBar];
            break;
        }
        case ReachableViaWWAN:
        case ReachableViaWiFi:
        {
            [self hideNetStateBar];
            break;
        }
    }
}

-(void)alertNetworkStatus{
    
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"当前无网络，是否进行设置？"
                                          cancelButtonTitle:@"取消"
                                              cancelHandler:^(SIAlertView *alertView) {}
                                     destructiveButtonTitle:@"马上设置"
                                         destructiveHandler:^(SIAlertView *alertView) {
                                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
                                             
                                         }];
    alert.alignment=NSTextAlignmentLeft;
    [alert show];
}



- (void)tapNetworkAction:(id)sender{
    [self alertNetworkStatus];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidUnload{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reachabilityChanged:nil];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [self.tabBarController.tabBar setHidden:!self.hasTabBarFlag];
}


//创建postdata
- (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict{
    
    return nil;
}

- (NSString *)uploadWithImage:(UIImage *)image{
    
    return nil;
}

- (NSString *)uploadWithImage:(UIImage *)image url:(NSString *)url{
    
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    NSString *serviceUrl = [NSString stringWithFormat:@"%@%@",self.serviceIPInfo,url];
    
    NSDate *now = [NSDate new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"IMG_%@",[formatter stringFromDate:now]];
    
    MyOperation *pic = [MyOperation new];
    pic.theImage=image;
    pic.fileName = fileName;
    NSDictionary *result = [pic uploadingWithUrl:serviceUrl];
    [MBProgressHUD hideAllHUDsForView:ShareAppDelegate.window animated:YES];
    if (result[@"message"]) {
        return result[@"message"][@"path"];
    }
    return nil;

}

- (void)roundImageView:(UIImageView *)imageView withColor:(UIColor *)color{
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.bounds.size.width/2;
    imageView.layer.borderWidth = 1.0;
    if (!color) {
        color = [UIColor whiteColor];
    }
    imageView.layer.borderColor = color.CGColor;
}

- (void)setImageWithURL:(NSString *)path imageView:(UIImageView *)imageView placeholderImage:(UIImage *)image{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@%@",kBaseURL,kURL_token_download,path];
    NSURL *URL = [NSURL URLWithString:url];
    [imageView setImageWithURL:URL placeholderImage:image];
}

- (NSString *)createFolderPath{
    
    NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    NSDictionary *info = [[NSUserDefaults standardUserDefaults] objectForKey:kOneselfInfo];
    NSString *username = info[@"objname"];
    
    path = [path stringByAppendingPathComponent:username];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:path];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

- (BOOL)isFileExistsPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:path];
}


#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)image:(UIImage *)image resizableImageWithCapInsets:(UIEdgeInsets)insets size:(CGSize)size{

    image= [image resizableImageWithCapInsets:insets];
    
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return image;
}

//等比缩放（通过缩放系数）
- (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    UIGraphicsBeginImageContext(size); // this will crop
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [self defaultRightButtonWithTitle:title];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (NSString *)toJSONWithObject:(id)object{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length]> 0 && error == nil){
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else{
        return nil;
    }
}

//设置cookie
- (void)setCookie:(NSURL *)url{
    
    NSDictionary *result =[[NSUserDefaults standardUserDefaults] objectForKey:kOneselfInfo];
    
    NSString *sessionid=result[@"sessionid"];
    
    NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];
    @try {
        [cookiePropertiesUser setObject:@"JSESSIONID" forKey:NSHTTPCookieName];
        [cookiePropertiesUser setObject:sessionid forKey:NSHTTPCookieValue];
        [cookiePropertiesUser setObject:[url host] forKey:NSHTTPCookieDomain];
        //    [cookiePropertiesUser setObject:[url host] forKey:NSHTTPCookieOriginURL];
        [cookiePropertiesUser setObject:[url path] forKey:NSHTTPCookiePath];
        [cookiePropertiesUser setObject:@"0" forKey:NSHTTPCookieVersion];
        
        [cookiePropertiesUser setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@ host:%@",exception,[url host]);
    }
    
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
}
//根据自定义Font自适应宽度高度Label
- (UILabel *)adaptiveLabelFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(frame.origin.x,frame.origin.y,0,0)];
    [label setNumberOfLines:0];
    label.text = text;
    label.font = font;
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [label sizeThatFits:size];
    [label setFrame:CGRectMake(frame.origin.x,frame.origin.y,labelsize.width, labelsize.height)];
    return label;
}
//根据自定义Font自适应宽度高度Label
- (UILabel *)adaptiveLabelWithFrame:(CGRect)frame detail:(NSString*)detail fontSize:(CGFloat)fontSize{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:detail];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont fontWithName:kFontName size:fontSize]
                    range:NSMakeRange(0, [detail length])];
    
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:kFontColor_Contacts
                    range:NSMakeRange(0, [detail length])];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraph.lineSpacing = 5;
    //段落间距
    paragraph.paragraphSpacing = 5;
    //对齐方式
    paragraph.alignment = NSTextAlignmentLeft;
    //指定段落开始的缩进像素
    paragraph.firstLineHeadIndent = 0;
    //调整全部文字的缩进像素
    paragraph.headIndent = 5;
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:paragraph
                    range:NSMakeRange(0, [detail length])];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:frame];
    //自动换行
    detailLabel.numberOfLines = 0;
    //设置label的富文本
    detailLabel.attributedText = attrStr;
    //label高度自适应
    [detailLabel sizeToFit];
    
    return detailLabel;
}

//去除字符串中间空格
- (NSString *)removeIntermediateSpace:(NSString *)theString{
    
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [theString componentsSeparatedByCharactersInSet:whitespaces];
    
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    
    return [filteredArray componentsJoinedByString:@""];
}

//压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)targetSize{
//    // Create a graphics image context
//    UIGraphicsBeginImageContext(targetSize);
//    
//    // Tell the old image to draw in this new context, with the desired
//    // new size
//    [image drawInRect:CGRectMake(0,0,targetSize.width,targetSize.height)];
//    
//    // Get the new image from the context
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // End the context
//    UIGraphicsEndImageContext();
//    
//    // Return the new image.
//    return newImage;
    
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (NSMutableURLRequest *)getRequestWithPath:(NSString *)path{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@%@",kBaseURL,kURL_token_download,path];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if (token.length>0) {
        [request setValue:token forHTTPHeaderField:@"token"];
    }
    [request setValue:@"ios" forHTTPHeaderField:@"user-agent"];
    
    return request;
}

- (UIView *)drawViewWithFrame:(CGRect)frame title:(NSString *)title textField:(UITextField **)textField read:(BOOL)read action:(nullable SEL)action must:(BOOL)must tag:(NSInteger)tag{
    
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
    
    UITextField *valueTextField = [UITextField new];
    valueTextField.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+2,(CGRectGetHeight(frame) -20)/2,CGRectGetWidth(frame)-77, 20);
    valueTextField.textColor = kFontColor_Contacts;
    valueTextField.font = [UIFont fontWithName:kFontName size:14];
    valueTextField.userInteractionEnabled = !read;
    NSString *placeholder = read?@"点击":@"输入";
    NSString *str = [self removeIntermediateSpace:title];
    
    valueTextField.placeholder = [NSString stringWithFormat:@"请%@%@",placeholder,str];
    [view addSubview:valueTextField];
    
    *textField = valueTextField;
    
    if (must) {
        UILabel *starLabel1 = [UILabel new];
        starLabel1.frame = CGRectMake(self.viewWidth -15, 10,10, 20);
        starLabel1.text = @"*";
        starLabel1.textColor = [UIColor redColor];
        [view addSubview:starLabel1];
    }
    
    if (read && action) {
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *viewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
        [view addGestureRecognizer:viewTapGesture];
    }
    
    return view;
}


@end
