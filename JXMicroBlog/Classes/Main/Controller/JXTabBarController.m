//
//  JXTabBarController.m
//  JXWeiBo
//
//  Created by 王加祥 on 16/6/15.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXTabBarController.h"
#import "JXHomeController.h" // 首页
#import "JXMessageController.h" // 消息
#import "JXDiscoveryController.h" // 发现
#import "JXMeController.h" // 我
#import "JXSendStatusViewController.h" // 发表状态
#import "JXTabBar.h"
#import "JXHomeUnreadeCountModel.h" // 未读模型
#import "JXHomeUnreadeCountParam.h" // 未读参数
#import "JXStatusTool.h"


@interface JXTabBarController ()
/** 首页 */
@property (nonatomic,weak) JXHomeController * home;
/** 消息 */
@property (nonatomic,weak) JXMessageController * message;
/** 我 */
@property (nonatomic,weak) JXMeController * me;
@end

@implementation JXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建子控制器
    [self setupAllChildVc];
    
    // 定时器获取未读
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(getUnread) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
 - (void)getUnread {
    JXAccount *account = [JXAccountTool account];
    JXHomeUnreadeCountParam *param = [JXHomeUnreadeCountParam params];
    param.uid = account.uid ;
    [JXStatusTool unreadeCountWithParams:param success:^(JXHomeUnreadeCountModel *homeStatus) {
        
        if (homeStatus.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",homeStatus.status];
        }
        
        if (homeStatus.messageCount == 0 ) {
            self.message.tabBarItem.badgeValue = nil;
        } else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",homeStatus.messageCount];
        }
        
        if (homeStatus.follower == 0) {
            self.me.tabBarItem.badgeValue = nil;
        } else {
            self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",homeStatus.follower];
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = homeStatus.totalCount;
        
    } failure:^(NSError *error) {
        
    }];
}


/**
 *  创建子控制器
 */
- (void)setupAllChildVc {
    JXHomeController * home = [[JXHomeController alloc] init];
    [self addOneChildVc:home
                  title:@"首页"
              imageName:@"tabbar_home"
        selectImageName:@"tabbar_home_selected"
       selectTitleColor:[UIColor orangeColor]];
    self.home = home;

    JXMessageController * message = [[JXMessageController alloc] init];
    [self addOneChildVc:message
                  title:@"消息"
              imageName:@"tabbar_message_center"
        selectImageName:@"tabbar_message_center_selected"
       selectTitleColor:[UIColor orangeColor]];
    self.message = message;

    JXDiscoveryController * discover = [[JXDiscoveryController alloc] init];
    [self addOneChildVc:discover
                  title:@"发现"
              imageName:@"tabbar_discover"
        selectImageName:@"tabbar_discover_selected"
       selectTitleColor:[UIColor orangeColor]];
    
    JXMeController * me = [[JXMeController alloc] init];
    [self addOneChildVc:me
                  title:@"我"
              imageName:@"tabbar_profile"
        selectImageName:@"tabbar_profile_selected"
       selectTitleColor:[UIColor orangeColor]];
    self.me = me;
    
    // 替换系统的TabBar
    JXTabBar *customerTabBar = [[JXTabBar alloc] init];
    customerTabBar.CenterBtnClickBlock = ^(){
        JXSendStatusViewController *sendStatus = [[JXSendStatusViewController alloc] init];
        JXNavigationController *nav = [[JXNavigationController alloc] initWithRootViewController:sendStatus];
        [self presentViewController:nav animated:YES completion:nil];
    };
    customerTabBar.frame = self.tabBar.bounds;
    [self setValue:customerTabBar forKeyPath:@"tabBar"];

}

/**
 *  添加一个子控制器
 *
 *  @param childVc          子控制器对象
 *  @param title            标题
 *  @param imageName        图片
 *  @param selectImageName  选中图片
 *  @param selectTitleColor 选中图片颜色
 */
- (void)addOneChildVc:(UIViewController *)childVc
                title:(NSString *)title
            imageName:(NSString *)imageName
      selectImageName:(NSString *)selectImageName
     selectTitleColor:(UIColor *)selectTitleColor{
    
    // 这里设置随机色，表明一创建就已经访问了四个控制器，说明四个控制器都已经创建，很消耗内存
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    childVc.tabBarItem.image = [UIImage originalImageWithImageName:imageName];
    childVc.tabBarItem.selectedImage = [UIImage originalImageWithImageName:selectImageName];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = selectTitleColor;
    [childVc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    
    // 添加导航控制器
    JXNavigationController * nav = [[JXNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
