//
//  AppDelegate.m
//  wawawa
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//


#import "AppDelegate.h"
#import "LGMainViewController.h"

#import <BmobSDK/BmobGPSSwitch.h>


#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

#import "WXApi.h"
#import "OpenUDID.h"

#import "MLNavigationController.h"


#import "BOAD.h"

#import "APService.h"



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}





//都是正式的Key
- (void)setShare
{
    [ShareSDK registerApp:@"2aab33b47c5a"];
    
    [ShareSDK  connectSinaWeiboWithAppKey:@"296180164"
                                appSecret:@"2687c3c49bed2402394f00b8f4cc2b6a"
                              redirectUri:@"http://www.pgyer.com/tiancai"
                              weiboSDKCls:[WeiboSDK class]];
    
    [ShareSDK connectQZoneWithAppKey:@"1101990823"
                           appSecret:@"VEVvOoLp07h6WGli"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"1101990823"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectWeChatWithAppId:@"wxd747fdb10842a434" wechatCls:[WXApi class]];
}

- (void)setBmob
{
    [BmobGPSSwitch gpsSwitch:NO];
    NSString *openUDID  = [OpenUDID value];
    [[NSUserDefaults standardUserDefaults] setObject:openUDID forKey:@"UUID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setAds
{
    
    [BOAD setLogEnabled:YES];// 开启广告日志
    
    
    // demo
//    [BOAD setAppId:@"b9900376c93811e3b32bf8bc123c968c" appScrect:@"047eaed77e8e92e38cb6528fbeb4589e"];// 设置全局的应用ID和应用密钥，替换为自己的应用ID和应用密钥
    
//    //my key
    [BOAD setAppId:@"2c195f54211e11e48485f8bc123d7e98" appScrect:@"02bb90c04c6bdbff85220faa2db54588"];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    
    
    [self setBmob];//后台数据
    [self setShare];//分享
    [self setAds];
    [self initShareURL];
    
    
    NSDictionary *muDict=[[NSDictionary alloc]initWithObjectsAndKeys:@"80",@"1",@"70",@"2",@"60",@"3",@"50",@"4",@"40",@"5",@"35",@"6",@"30",@"7",@"28",@"8",@"26",@"9",@"24",@"10",@"22",@"11",@"21",@"12",@"20",@"13",@"19.5",@"14",@"19",@"15",@"18.8",@"16",@"18.6",@"17",@"18.4",@"18",@"18.2",@"19",@"18",@"20", nil];
    
    NSString *plistSourcePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Preferences/JR.wawawa.plist"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:plistSourcePath isDirectory:NO]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"999999999" forKey:@"JingDianScore"];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"ChanScore"];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"JiSuScore"];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"ChuangGuanScore"];
        [[NSUserDefaults standardUserDefaults] setObject:muDict forKey:@"points"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    [self.window makeKeyAndVisible];
    
    //去掉状态栏
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    LGMainViewController *vc = [[LGMainViewController alloc] init];
    MLNavigationController *nav = [[MLNavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;

    
//
    
    
    [BmobUtil setUser];//创建用户
    
    
    

    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
    [self.window makeKeyAndVisible];
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    [APService setupWithOption:launchOptions];
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
    [APService setTags:[NSSet setWithObjects:uuid,nil] alias:uuid callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];

    
    
    
    
    
    return YES;
}


- (void)initShareURL
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"http://www.pgyer.com/tiancai" forKey:@"URL"];
    [[NSUserDefaults standardUserDefaults] setObject:@"天才帝一步，比比谁速度！自从用了“天才帝一步”，妈妈再也不担心我的算术了！ " forKey:@"content"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"isShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"XiaZai"];
    [bquery orderByDescending:@"createdAt"];
    bquery.limit = 10;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error && array.count != 0) {
            BmobObject *o = [array objectAtIndex:0];
            NSLog(@"%@",[o objectForKey:@"URL"]);
            [[NSUserDefaults standardUserDefaults] setObject:[o objectForKey:@"URL"] forKey:@"URL"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    
    BmobQuery   *bqueryF = [BmobQuery queryWithClassName:@"FaBuGongGao"];
    [bqueryF orderByDescending:@"createdAt"];
    bqueryF.limit = 10;
    [bqueryF findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error && array.count != 0) {
            BmobObject *o = [array objectAtIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:[o objectForKey:@"content"] forKey:@"content"];            
            [[NSUserDefaults standardUserDefaults] setObject:[o objectForKey:@"contentPush"] forKey:@"contentPush"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
    }];
    
    
    BmobQuery   *bqueryA = [BmobQuery queryWithClassName:@"Ads"];
    [bqueryA orderByDescending:@"createdAt"];
    bqueryA.limit = 10;
    [bqueryA findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error && array.count != 0)
        {
            BmobObject *o = [array objectAtIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:[o objectForKey:@"isShow"] forKey:@"isShow"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    [application setApplicationIconBadgeNumber:0];
    
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppStart" object:nil];
    
    [application setApplicationIconBadgeNumber:0];
//    [APService setBadge:_badge++];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [APService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken：%@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
}

//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
#endif

#pragma mark -

- (void)networkDidSetup:(NSNotification *)notification
{
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification
{
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification
{
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification
{
    NSLog(@"已登录");
}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
//    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    
//    NSString *str = [NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content];
//    NSLog(@"%@",str);
    
    [[NSUserDefaults standardUserDefaults] setObject:content forKey:@"contentPush"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}






- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}



@end
