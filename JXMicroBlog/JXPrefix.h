//
//  JXPrefix.h
//  JXMicroBlog
//
//  Created by 王加祥 on 2016/12/12.
//  Copyright © 2016年 王加祥. All rights reserved.
//

#ifndef JXPrefix_h
#define JXPrefix_h

#ifdef DEBUG //调试状态,打开Log功能
#define JXLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else//发布状态,关闭Log功能
#define JXLog(...)
#endif

#ifdef __OBJC__

/******************************************************************************/
/** 随机色 */
#define kRandColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
/** RGB颜色 */
#define kRGBColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/** 主题色 */
#define kTintColor [UIColor colorWithRed:0/255.0 green:0/255.0 blue:102/255.0 alpha:1.0f]

/******************************************************************************/
/** 屏幕宽度 */
#define kWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kHeight [UIScreen mainScreen].bounds.size.height
/** 屏幕尺寸 */
#define kScreen [UIScreen mainScreen].bounds
/** 主屏幕 */
#define kWinow [UIApplication sharedApplication].keyWindow
/** 屏幕比例 */
#define kSreenWidthScale   kWidth/320.0  //以iphone5 屏幕为基准
#define kScale(x)   x*kSreenWidthScale
/** 底部状态栏高度 */
#define kBottomH 49
/** 底部状态栏高度 */
#define kStatusH 20
/** 底部状态栏高度 */
#define kNavigateH 44

/******************************************************************************/
/** 图片分类 */
#import "UIImage+XHExtension.h"
/** 尺寸分类 */
#import "UIView+JXExtension.h"
/**  UIBarButtonItem按钮分类 */
#import "UIBarButtonItem+JXExtension.h"
/**  导航 */
#import "MBProgressHUD+MJ.h"
#import "NSDate+MJ.h"

/******************************************************************************/
/**  自定义导航 */
#import "JXNavigationController.h"



/******************************************************************************/
#import "Masonry.h"
#import "JXHTTPTool.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "AFNetworking.h"
#import "MJRefresh.h"


#import "JXAccount.h"
#import "JXAccountTool.h"



/*************************** OAuth **********************************************/
// 获取token
#define kOAuthGetToken @"https://api.weibo.com/oauth2/access_token"

/*************************** 首页 **********************************************/
// 请求首页信息接口
#define kHomeTimeLineUrl @"https://api.weibo.com/2/statuses/home_timeline.json"
// 获取用户昵称
#define kHomeShowUserUrl @"https://api.weibo.com/2/users/show.json"
// 未读消息个数
#define kUnreadeCountUrl @"https://rm.api.weibo.com/2/remind/unread_count.json"
// 获取首页详细评论
#define kHomeDetailUrl @"https://api.weibo.com/2/comments/show.json"
// cell表格参数
// cell内边距
#define kHomeCellMargin 10
// 微博昵称
#define kHomeOriginalNameFont [UIFont systemFontOfSize:14]
// 微博时间
#define kHomeOriginalTimeFont [UIFont systemFontOfSize:12]
// 微博来源
#define kHomeOriginalSourceFont kHomeOriginalTimeFont
// 微博正文
#define kHomeOriginalContentFont [UIFont systemFontOfSize:15]


// 转发昵称
#define kHomeRetweetNameFont kHomeOriginalTimeFont
// 转发时间
#define kHomeRetweetContenFont kHomeOriginalContentFont
// 记录富文本中出现的连接等
#define kHomeStatusLinks @"kHomeStatusLinks"


/*************************** 发表心情 **********************************************/
typedef enum {
    ComposeTypeCamera = 1 << 0 , // 相机
    ComposeTypePhoto = 1 << 1, // 相册
    ComposeTypeMention = 1 << 2, // @人
    ComposeTypeImport = 1 << 3 , // 重要 ##
    ComposeTypeEmotion = 1 << 4 , // emotion表情
}ComposeType;

// 表情的最大行数
#define JXEmotionMaxRows 3
// 表情的最大列数
#define JXEmotionMaxCols 7
// 每页最多显示多少个表情
#define JXEmotionMaxCountPerPage (JXEmotionMaxRows * JXEmotionMaxCols - 1)

/*************************** 底部工具条 **********************************************/
typedef enum {
    HomeStatusTypeRetweet = 1 << 10 , // 转发
    HomeStatusTypeComment = 1 << 20, // 评论
    HomeStatusTypePraise = 1 << 30 // 点赞
}HomeStatusType;

// 发表没有图片的微博
#define kSendWithOutPhoto @"https://api.weibo.com/2/statuses/update.json"
// 发表有图片的微博
#define kSendWithPhoto @"https://upload.api.weibo.com/2/statuses/upload.json"


// 键盘选中通知
#define kJXEmotionDidSelectedNotification @"kJXEmotionDidSelectedNotification"
// 键盘删除按钮通知
#define kJXEmotionDidDeleteNotification @"kJXEmotionDidDeleteNotification"
// 键盘选中通知key
#define kJXDidSelectedEmotion @"kJXDidSelectedEmotion"
// 点击发出通知
#define kJXLinkDidSelectedNotification @"kJXLinkDidSelectedNotification"
#endif
#endif /* JDPrefix_h */

