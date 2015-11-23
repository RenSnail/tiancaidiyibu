//
//  LGMainViewController.m
//  wawawa
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//


#import "LGMainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JingDianViewController.h"
#import "ChanViewController.h"
#import "JiSuViewController.h"
#import "ChuangGuanViewController.h"



#import "AboutUsViewController.h"

@interface LGMainViewController ()<BOADBannerViewDelegate>
{
    UILabel *_labelTip;
    
    NSString *_getImagePath;
    NSString *_url;
    NSString *_content;
    

}

@end

@implementation LGMainViewController







- (void)bannerAction
{
    BOADBannerView *bannerView;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        bannerView = [[BOADBannerView alloc] initWithAdSize:BOADAdSizeBanner origin:CGPointMake(0, self.view.frame.size.height - CGSizeFromBOADAdSize(BOADAdSizeBanner).height)];
    } else {
        bannerView = [[BOADBannerView alloc] initWithAdSize:BOADAdSizeSmartBannerPortrait origin:CGPointMake(0, self.view.frame.size.height - CGSizeFromBOADAdSize(BOADAdSizeSmartBannerPortrait).height)];
    }
    bannerView.delegate = self;
    bannerView.rootViewController = self;
    [bannerView loadAd];
    [self.view addSubview:bannerView];
}

#pragma mark - BOADBannerViewDelegate
- (void)boadBannerViewWillLoadAd:(BOADBannerView *)bannerView {
    // 加载开始
}

- (void)boadBannerViewDidLoadAd:(BOADBannerView *)bannerView {
    // 加载完毕
}

- (void)boadBannerViewDidTapAd:(BOADBannerView *)bannerView {
    // 点击广告
    
    [BmobUtil setClick];
    
    
}


- (void)boadBannerView:(BOADBannerView *)banner didFailToReceiveAdWithError:(BOADError *)error {
    // 加载失败
}










- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    switch (alertView.tag) {
        case 3:
        {
            switch (buttonIndex) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"URL"]]];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
  
            
            
        default:
            break;
    }
    
}

- (void)testVerson
{
    
    _update = [[NSUserDefaults standardUserDefaults] integerForKey:@"_update"];
    
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    
    BmobQuery   *bquery1 = [BmobQuery queryWithClassName:@"UD"];
    [bquery1 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error && array.count != 0) {
            BmobObject *o = [array objectAtIndex:0];
            NSLog(@"%@",[o objectForKey:@"need"]);
            if (![[o objectForKey:@"need"] isEqualToString:nowVersion]) {
                
                NSLog(@"_update  %d",_update);
                
                
                if (_update%5==0)
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"亲，有新版本啦!" delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"立刻更新", nil];
                    alert.tag = 3;
                    [alert show];
                    //                [self showHint:@"新版本到“关于我们”点击“版本更新”! "];
                    
                }
                _labelTip.text = @"亲，有新版本啦! 到“关于我们”点击“版本更新”!";
                
                
                _update++;
                [[NSUserDefaults standardUserDefaults] setInteger:_update forKey:@"_update"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else
            {
                //                _labelTip.text = @"";
                [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"_update"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    

    
    
    
   

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:62.0/255.0 blue:82.0/255.0 alpha:1.0];
    label.textColor = [UIColor whiteColor];
    label.frame = CGRectMake(60, 40, 200, 35);
    label.text = @"天才帝一步";
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 18;
    label.clipsToBounds = YES;
    [self.view addSubview:label];
    
    NSArray *arr = [NSArray arrayWithObjects:@"经典",@"禅",@"急速",@"闯关", nil];
    
    for (int i = 0; i< 4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(60, 100 + i*50, 200, 35);
        btn.tag = i + 100;
        [btn setTitleColor:[UIColor colorWithRed:225.0/255.0 green:89.0/255.0 blue:99.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(actionPush:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    
    UIButton *buttonAboutUs = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonAboutUs.titleLabel.font = [UIFont systemFontOfSize:17];
    [buttonAboutUs setTitle:@"关于我们" forState:UIControlStateNormal];
    buttonAboutUs.frame = CGRectMake(0,   320, 320, 40);
    [self.view addSubview:buttonAboutUs];
    [buttonAboutUs setTitleColor:[UIColor colorWithRed:225.0/255.0 green:89.0/255.0 blue:99.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [buttonAboutUs addTarget:self action:@selector(actionJianCe:) forControlEvents:UIControlEventTouchUpInside];
    

    UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(2, 400, 316, 30)];
    labelTip.numberOfLines = 0;
    labelTip.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:labelTip];
    labelTip.textAlignment = NSTextAlignmentCenter;
    labelTip.textColor = [UIColor redColor];
    labelTip.backgroundColor = [UIColor clearColor];
    _labelTip = labelTip;
//    _labelTip.text = @"亲，有新版本啦! 到“关于我们”点击“版本更新”!";

    
    UIButton *buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonShare.titleLabel.font = [UIFont systemFontOfSize:17];
    [buttonShare setTitle:@"分享" forState:UIControlStateNormal];
    buttonShare.frame = CGRectMake(0,   360, 320, 40);
    [self.view addSubview:buttonShare];
    [buttonShare setTitleColor:[UIColor colorWithRed:225.0/255.0 green:89.0/255.0 blue:99.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonShare addTarget:self action:@selector(actionShare) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSString *isShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShow"];
    if (![isShow isEqualToString:@"0"] || [isShow isEqualToString:@""])
    {
        [self bannerAction];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaStartMain) name:@"AppStart"object:nil];

    
    [self testVerson];

    
    NSString *content = [[NSUserDefaults standardUserDefaults] objectForKey:@"contentPush"];
    _labelTip.text = content;

}

#pragma mark - GetChance

- (void)mediaStartMain
{
    
    [self testVerson];
    
    
    NSString *isShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShow"];
    if (![isShow isEqualToString:@"0"] || [isShow isEqualToString:@""])
    {
        [self bannerAction];
    }
}

- (void)actionShare
{
    [self screenShot];

}



/**
 
 *截图功能
 
 */

-(void)screenShot{
    
    
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    //以下为图片保存代码
    
//    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
    
    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *pictureName= @"screenShow.png";
    
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    
    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
    
    CGImageRelease(imageRefRect);
    
    
    _getImagePath = savedImagePath;
    
    //从手机本地加载图片
    [self actionFen:nil];
    
}




- (IBAction)actionFen:(id)sender {
    
    
    _url = [[NSUserDefaults standardUserDefaults] objectForKey:@"URL"];
    _content = [[NSUserDefaults standardUserDefaults] objectForKey:@"content"];
    
    
    id<ISSContainer> container = [ShareSDK container];
    
    if ([[UIDevice currentDevice] isPad])
        [container setIPadContainerWithView:sender
                                arrowDirect:UIPopoverArrowDirectionUp];
    else
        [container setIPhoneContainerWithViewController:self];
    
    id<ISSContent> publishContent = nil;
    
    NSString *contentString = [NSString stringWithFormat:@"%@%@",_content,_url];
    NSString *titleString   = _content;
    NSString *urlString     = _url;
    NSString *description   = _url;
    
    
    
    
//    publishContent = [ShareSDK content:contentString
//                        defaultContent:@""
//                                 image:[ShareSDK imageWithPath:_getImagePath]
//                                 title:titleString
//                                   url:urlString
//                           description:description
//                             mediaType:SSPublishContentMediaTypeText];
    
    
    //发送内容给微信
    publishContent = [ShareSDK content:contentString
                                defaultContent:@""
                                         image:[ShareSDK jpegImageWithImage:[UIImage imageWithContentsOfFile:_getImagePath] quality:1]
                                         title:titleString
                                           url:urlString
                                   description:description
                                     mediaType:SSPublishContentMediaTypeNews];

    
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                    [self showHint:@"分享成功"];
                                    
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    [self showHint:@"分享失败"];
                                    
                                }
                            }];

    
}







- (IBAction)actionJianCe:(id)sender {
    
    
    AboutUsViewController *vc = [[AboutUsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - IBAction

- (IBAction)actionPush:(UIButton *)button
{
    switch (button.tag) {
        case 100:
        {
            JingDianViewController *jingDianVC = [[JingDianViewController alloc] init];
            [self.navigationController pushViewController:jingDianVC animated:NO];
        }
            break;
        case 101:
        {
            ChanViewController *chanVC=[[ChanViewController alloc]init];
            [self.navigationController pushViewController:chanVC animated:NO];
        }
            break;
        case 102:
        {
            JiSuViewController *jiSuVC=[[JiSuViewController alloc]init];
            [self.navigationController pushViewController:jiSuVC animated:NO];
        }
            break;
        case 103:
        {
            ChuangGuanViewController *chuangGuan=[[ChuangGuanViewController alloc]init];
            [self.navigationController pushViewController:chuangGuan animated:NO];
        }
            break;
            
            
        default:
            break;
    }
}





@end
