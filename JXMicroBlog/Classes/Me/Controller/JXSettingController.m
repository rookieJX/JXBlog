//
//  JXSettingController.m
//  JXMicroBlog
//
//  Created by 王加祥 on 2017/3/11.
//  Copyright © 2017年 王加祥. All rights reserved.
//

#import "JXSettingController.h"
#import "JXGlobalGroup.h" // 组数据
#import "JXGlobalItem.h"
#import "JXGlobalSwitchItem.h"
#import "JXGlobalArrowItem.h"
#import "JXGlobalTextItem.h"
#import "JXMeMessageController.h"

@implementation JXSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化数据模型
    [self setupGroups];
}
- (void)setupGroups {
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    
    // 设置退出按钮
    [self setupFooter];
    
}

- (void)setupFooter {
    UIButton *logout =[UIButton buttonWithType:UIButtonTypeCustom];
    [logout setTitle:@"退出当前登录" forState:UIControlStateNormal];
    logout.titleLabel.font = [UIFont systemFontOfSize:15];
    [logout setTitleColor:kRGBColor(255, 10, 0, 1.0) forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    logout.h = 35;
    self.tableView.tableFooterView = logout;
}

- (void)setupGroup0 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组的所有行数据
    JXGlobalArrowItem *countItem = [JXGlobalArrowItem itemWithTitle:@"账号管理"];
    
    JXGlobalArrowItem *safeItem = [JXGlobalArrowItem itemWithTitle:@"账号安全"];
    
    group.items = @[countItem,safeItem];
}

- (void)setupGroup1 {
    
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    
    // 设置组的所有行数据
    JXGlobalArrowItem *message = [JXGlobalArrowItem itemWithTitle:@"消息设置"];
    message.destVcClass = [JXMeMessageController class];
    
    JXGlobalArrowItem *shield = [JXGlobalArrowItem itemWithTitle:@"屏蔽设置"];
    
    JXGlobalArrowItem *pravicy = [JXGlobalArrowItem itemWithTitle:@"隐私"];
    
    JXGlobalArrowItem *genera = [JXGlobalArrowItem itemWithTitle:@"通用设置"];
    group.items = @[message,shield,pravicy,genera];
}

- (void)setupGroup2 {
    JXGlobalGroup *group = [JXGlobalGroup group];
    [self.groups addObject:group];
    
    // 设置组的所有行数据
    JXGlobalTextItem *clean = [JXGlobalTextItem itemWithTitle:@"清理缓存"];
    clean.globalItemOperationBlock = ^{
        JXLog(@"处理点击事件");
//        [MBProgressHUD showMessage:@"正在清理缓存"];
    };
    // 获取文件目录路径
    NSString *fileName = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [fileName stringByAppendingPathComponent:@"/default/com.hackemist.SDWebImageCache.default"];
    long long size = [self fileSizeAtFile:filePath];
    clean.text = [NSString stringWithFormat:@"(%.1f M)",size / (1000.0 * 1000.0)];
    
    JXGlobalArrowItem *opinion = [JXGlobalArrowItem itemWithTitle:@"意见反馈"];
    
    JXGlobalArrowItem *service = [JXGlobalArrowItem itemWithTitle:@"客服中心"];
    
    JXGlobalArrowItem *about = [JXGlobalArrowItem itemWithTitle:@"关于微博"];
    group.items = @[clean,opinion,service,about];

}

- (long long)fileSizeAtApp {

    // 获取文件目录路径
    NSString *fileName = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [fileName stringByAppendingPathComponent:@"/default/com.hackemist.SDWebImageCache.default"];
    
    // 文件管理
    NSFileManager *fileManager = [NSFileManager defaultManager];

    long long size = 0;
    
    // 获取文件夹中的所有文件
    NSArray *files = [fileManager subpathsAtPath:filePath];
    // 将文件中所有的文件拼接为路劲
    for (NSString *subPath in files) {
        NSString *subFile = [filePath stringByAppendingPathComponent:subPath];
        NSDictionary *dict = [fileManager attributesOfItemAtPath:subFile error:nil];
        size += [dict[NSFileSize] longLongValue];
    }
    return size;
}

- (long long)fileSizeAtFile:(NSString *)file
{
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:file isDirectory:&isDirectory];
    // 文件\文件夹不存在
    if (fileExists == NO) return 0;
    
    // 3.判断file是否为文件夹
    if (isDirectory) { // 是文件夹
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:file error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [file stringByAppendingPathComponent:subpath];
            totalSize += [self fileSizeAtFile:fullSubpath];
        }
        return totalSize;
    } else { // 不是文件夹, 文件
        // 直接计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:file error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

@end
