//
//  HeadViewController.h
//  JCDB
//
//  Created by WangJincai on 16/1/1.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"


@interface MyScrollView:UIScrollView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end



typedef void(^SuccessRefreshViewBlock)();



@interface HeadViewController : UIViewController {
    
}
@property (nonatomic ,assign) BOOL hasTabBarFlag;//是否是显示TabBarView标志，默认不是NO
@property (nonatomic ,assign) BOOL hasBackWardFlag;

@property (nonatomic ,strong) NSString *serviceIPInfo;
@property (nonatomic ,assign) CGFloat viewWidth;
@property (nonatomic ,assign) CGFloat viewHeight;
@property (nonatomic ,strong) MyScrollView *scrollView;
@property (nonatomic ,strong) UIView *iv_netstate;
@property (nonatomic ,strong) NSString *classFlag;
@property (nonatomic ,strong) NSString *myUserName;


- (UIView *)searchViewWithFrame:(CGRect)frame;

- (void)backAction;

- (UIImage *)drawRoundWith:(NSString *)title size:(CGSize)size fillColor:(UIColor *)fillColor;

- (UIButton *)buttonForTitle:(NSString *)title action:(SEL)action;

- (NSString *)uploadWithImage:(UIImage *)image;
- (NSString *)uploadWithImage:(UIImage *)image url:(NSString *)url;

- (void)roundImageView:(UIImageView *)imageView withColor:(UIColor *)color;
- (void)setImageWithURL:(NSString *)path imageView:(UIImageView *)imageView placeholderImage:(UIImage *)image;

- (NSString *)createFolderPath;
- (BOOL)isFileExistsPath:(NSString *)path;

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

- (UIImage *)image:(UIImage *)image resizableImageWithCapInsets:(UIEdgeInsets)insets size:(CGSize)size;
- (void)showRightBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
//id转json格式字符串
- (NSString *)toJSONWithObject:(id)data;

- (void)setCookie:(NSURL *)url;

//根据自定义Font自适应宽度高度Label
- (UILabel *)adaptiveLabelFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font;

- (UILabel *)adaptiveLabelWithFrame:(CGRect)frame detail:(NSString*)detail fontSize:(CGFloat)fontSize;

//去除字符串中间空格
- (NSString *)removeIntermediateSpace:(NSString *)theString;

////压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
////等比缩放（通过缩放系数）
//- (UIImage*)imageCompressWithSimple:(UIImage*)image scale:(float)scale;

- (NSMutableURLRequest *)getRequestWithPath:(NSString *)path;

//删除红点数据
- (void)delRedPointWithId:(NSString *)_id type:(NSString *)type;


- (UIView *)drawViewWithFrame:(CGRect)frame title:(NSString *)title textField:(UITextField **)textField read:(BOOL)read action:(nullable SEL)action must:(BOOL)must tag:(NSInteger)tag;
@end

