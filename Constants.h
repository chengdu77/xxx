//
//  Constants.h
//  
//
//  Created by WangJincai on 16/6/13.
//
//

#ifndef KSJX_Constants_h
#define KSJX_Constants_h

//#import "UIColor+External.h"

#define kUploadFileUrl @""


#undef	RGB
#define RGB(R,G,B)		[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]

#undef	RGBA
#define RGBA(R,G,B,A)	[UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#undef	HEX_RGB
#define HEX_RGB(V)		[UIColor fromHexValue:V]

#undef	HEX_RGBA
#define HEX_RGBA(V, A)	[UIColor fromHexValue:V alpha:A]

//所有界面颜色
#define kALL_COLOR RGB(24,179,207)
#define kTabColor  RGB(227,227,227)
#define kLOGIN_COLOR RGB(229,118,20)

#define kBackgroundColor RGB(242,242,242)
#define kFontColor_Contacts RGB(67,74,84)
#define kFontColor [UIColor colorWithWhite:0.7 alpha:1.0]
#define kFontColor_A RGB(67,74,84)

#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define kFontName @"HelveticaNeue"
#define kFontNameB @"Helvetica-Bold"

#define kSuccessCode 1
#define kErrorInfomation @"未获取到数据！！"

#define kAddressHttps @"AddressHttps"
#define kOneselfInfo @"OneselfInfo"
#define kAddressTXURL @"AddressTXURL"

#define kCompel @"compel" //是否强制更新，－1否，1是
#define kDownloadAppUrl @"DownloadAppUrl"


#define kUSERNAME @"USERNAME"
#define kPASSWORD @"PASSWORD"
#define kREMBERFLAG @"REMBERFLAG"

#define kModifyPasswordNotification @"ModifyPasswordNotification"
#define kExpiredRequestsNotification @"ExpiredRequestsNotification"//退出登录(或者是令牌过期退出到登陆界面)

#define IOS9_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS8_OR_LATER ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )


#define kCellHeight 56;

#define kRows 10
#define kPages 1

#define kParameterName             @"data"//

//屏幕 rect
#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

#define ShareAppDelegate [UIApplication sharedApplication].delegate

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#define kRoundWidth 36 //Image的宽度
#define kTXImageViewWidth 120.0//上传头像大小
#define kImageSize 75
#define kImageNumber 4


typedef void (^PopViewController)();
typedef void (^PopViewBlock)(id object);
typedef void(^RefreshViewBlock)(id obj);

typedef void (^ReturnDataBLock) (id data);


#define kURL_token_upload @"token/upload" //22.文件上传
#define kURL_version @"version"//23.获取最新版本信息
#define kURL_token_download @"download/" //24.下载图片


#define kSUCCESSCODE  @"SUCCESS"
#define kExpiredRequests @"E00007"
//#define kBaseURL @"http://manager.mslhealth.cn/client"
#define kBaseURL @"http://192.168.3.25:8080/client"

#define kToken @"token"
#define kHXLoginName @"HXLoginName"//环信用户
#define kHXPassword @"HXPassword"//环信密码

#define kEntId @"entId"

#define kURL_login @"login"//1.登录接口
#define kURL_token_logout @"token/logout"//退出登录
#define kURL_register @"register"//用户注册／密码修改
#define kURL_sms @"sms"//短信

#define kURL_bbs_module @"bbs/module"//察看圈子主分类
#define kURL_bbs_module_child @"bbs/module/child"//察看圈子子分类
#define kURL_bbs_content_detail @"bbs/content/detail" //查看圈子里已发帖子
#define kURL_bbs_content_list @"bbs/content/list" //查看圈子分类所有列表或者回贴列表
#define kURL_bbs_content_list_page @"bbs/content/list/%@" //按页查看圈子分类发帖列表
#define kURL_bbs_content_post @"token/bbs/content/post" //圈子发帖和回帖
#define kURL_bbs_content_delete @"token/bbs/content/delete" //删除圈子已发帖子


#endif

