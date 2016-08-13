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

- (void)touchesBegan:(nullable NSSet *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesEnded:(nullable NSSet *)touches withEvent:(nullable UIEvent *)event;
@end


typedef void(^SuccessRefreshViewBlock)();



@interface HeadViewController : UIViewController {
    
}
@property (nonatomic ,assign) BOOL hasTabBarFlag;//是否是显示TabBarView标志，默认不是NO
@property (nonatomic ,assign) BOOL hasBackWardFlag;

@property (nonatomic ,strong,nullable) NSString * serviceIPInfo;
@property (nonatomic ,assign) CGFloat viewWidth;
@property (nonatomic ,assign) CGFloat viewHeight;
@property (nonatomic ,strong,nullable) MyScrollView *scrollView;
@property (nonatomic ,strong,nullable) UIView *iv_netstate;
@property (nonatomic ,strong,nullable) NSString *classFlag;
@property (nonatomic ,strong,nullable) NSString *myUserName;


- (UIView *__nonnull)searchViewWithFrame:(CGRect)frame;

- (void)backAction;

- (nullable UIImage *)drawRoundWith:(nullable NSString *)title size:(CGSize)size fillColor:(nullable UIColor *)fillColor;

- (nullable UIButton *)buttonForTitle:(nullable NSString *)title action:(nullable SEL)action;

- (nullable NSString *)uploadWithImage:(nullable UIImage *)image;
- (nullable NSString *)uploadWithImage:(nullable UIImage *)image url:(nullable NSString *)url;

- (void)roundImageView:(nullable UIImageView *)imageView withColor:(nullable UIColor *)color;
- (void)setImageWithURL:(nullable NSString *)path imageView:(nullable UIImageView *)imageView placeholderImage:(nullable UIImage *)image;

- (nullable NSString *)createFolderPath;
- (BOOL)isFileExistsPath:(nullable NSString *)path;

- (nullable UIImage *)imageByScalingToMaxSize:(nullable UIImage *)sourceImage;
- (nullable UIImage *)imageByScalingAndCroppingForSourceImage:(nullable UIImage *)sourceImage targetSize:(CGSize)targetSize;

- (nullable UIImage *)image:(nullable UIImage *)image resizableImageWithCapInsets:(UIEdgeInsets)insets size:(CGSize)size;
- (void)showRightBarButtonItemWithTitle:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action;
//id转json格式字符串
- (nullable NSString *)toJSONWithObject:(nullable id)data;

- (void)setCookie:(nullable NSURL *)url;

//根据自定义Font自适应宽度高度Label
- (nullable UILabel *)adaptiveLabelFrame:(CGRect)frame text:(nullable NSString *)text font:(nullable UIFont *)font;

- (nullable UILabel *)adaptiveLabelWithFrame:(CGRect)frame detail:(nullable NSString *)detail fontSize:(CGFloat)fontSize;

//去除字符串中间空格
- (nullable NSString *)removeIntermediateSpace:(nullable NSString *)theString;

////压缩图片
- (nullable UIImage *)imageWithImageSimple:(nullable UIImage *)image scaledToSize:(CGSize)newSize;
////等比缩放（通过缩放系数）
//- (UIImage*__nonnull)imageCompressWithSimple:(UIImage*__nonnull)image scale:(float)scale;

- (nullable NSMutableURLRequest *)getRequestWithPath:(nullable NSString *)path;

- (nullable UIView *)drawViewWithFrame:(CGRect)frame title:(nullable NSString *)title textField:(UITextField **)textField read:(BOOL)read action:(nullable SEL)action must:(BOOL)must tag:(NSInteger)tag;
@end

