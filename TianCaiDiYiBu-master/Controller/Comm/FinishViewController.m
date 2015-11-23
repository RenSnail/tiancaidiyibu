//
//  FinishViewController.m
//  wawawa
//
//  Created by ligang on 14-7-11.
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "FinishViewController.h"

#import "SuanUtil.h"
#import "FinishView.h"

#import "LGMainViewController.h"

#import "MLNavigationController.h"


@interface FinishViewController ()<FinishViewDelegate,BOADBannerViewDelegate>{
    NSString *_url;
    NSString *_content;    
    NSString *_getImagePath;
}

@end

@implementation FinishViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        

        
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _url = [[NSUserDefaults standardUserDefaults] objectForKey:@"URL"];
    _content = [[NSUserDefaults standardUserDefaults] objectForKey:@"content"];
    
    self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [imgView setImage:[SuanUtil createImageWithColor:[UIColor colorWithRed:239.0/255.0 green:62.0/255.0 blue:81.0/255.0 alpha:1.0]]];
    [self.view addSubview:imgView];
    
    
    UILabel *labelGo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    labelGo.backgroundColor = [UIColor clearColor];
    labelGo.text = @"天才帝一步";
    labelGo.font = [UIFont fontWithName:@"Helvetica" size:18];
    labelGo.textAlignment = NSTextAlignmentCenter;
    [imgView addSubview:labelGo];
    labelGo.textColor = [UIColor whiteColor];
    
    
    UILabel *labelStyle = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 50)];
    labelStyle.backgroundColor = [UIColor clearColor];
    labelStyle.text = _style;
    labelStyle.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    labelStyle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelStyle];
    labelStyle.textColor = [UIColor colorWithRed:131.0/255.0 green:169.0/255.0 blue:169.0/255.0 alpha:1.0];
    
    
    UILabel *labelResult = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 320, 50)];
    labelResult.backgroundColor = [UIColor clearColor];
    labelResult.text = _result;
    labelResult.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
    labelResult.textAlignment = NSTextAlignmentCenter;
    labelResult.textColor = [UIColor colorWithRed:233.0/255.0 green:66.0/255.0 blue:85.0/255.0 alpha:1.0];
    [self.view addSubview:labelResult];
    
    if (![_result isEqualToString:@"没搞定!"])
    {
        
        [BmobUtil setRecord:_result type:_style];

        UILabel *labelRecord = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 320, 50)];
        labelRecord.backgroundColor = [UIColor clearColor];
        labelRecord.font = [UIFont fontWithName:@"Helvetica" size:20];
        labelRecord.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:labelRecord];
        labelRecord.textColor = [UIColor colorWithRed:233.0/255.0 green:66.0/255.0 blue:85.0/255.0 alpha:1.0];
        
        
        NSString *jingDianScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"JingDianScore"];
        
        NSString *chanSoure=[[NSUserDefaults standardUserDefaults]objectForKey:@"ChanScore"];
        NSString *jiSuSoure=[[NSUserDefaults standardUserDefaults]objectForKey:@"JiSuScore"];
        NSString *chuangGuanSoure=[[NSUserDefaults standardUserDefaults]objectForKey:@"ChuangGuanScore"];
        if ([_style isEqualToString:@"经典模式"]) {
            labelResult.text = [NSString stringWithFormat:@"%@\"",_result];
            if ( [_result floatValue] > [jingDianScore floatValue] )
            {
                labelRecord.text = [NSString stringWithFormat:@"最牛%@\"",jingDianScore];
            }
            else
            {
                
                [[NSUserDefaults standardUserDefaults] setObject:_result forKey:@"JingDianScore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                labelRecord.text = @"新纪录诞生";
            }
        }
        else if([_style isEqualToString:@"禅模式"])
        {
            if ( [_result intValue]>[chanSoure intValue]||[chanSoure intValue]==0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:_result forKey:@"ChanScore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                labelRecord.text = @"新纪录诞生";
            }
            else
            {
                labelRecord.text = [NSString stringWithFormat:@"最牛%@",chanSoure];
            }
        }
        else if([_style isEqualToString:@"极速模式"])
        {
            labelResult.text = [NSString stringWithFormat:@"%@/s",_result];
            if ( [_result floatValue] > [jiSuSoure floatValue] )
            {
                [[NSUserDefaults standardUserDefaults] setObject:_result forKey:@"JiSuScore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                labelRecord.text = @"新纪录诞生";
                
            }
            else
            {
                labelRecord.text = [NSString stringWithFormat:@"最牛%@/s",jiSuSoure];
            }
            
        }
        else if([_style isEqualToString:@"闯关模式"])
        {
            labelRecord.text=[NSString stringWithFormat:@"第 %@ 关",chuangGuanSoure];
            UIButton *nextButton=[UIButton buttonWithType:UIButtonTypeCustom];
            nextButton.frame=CGRectMake(0, 270, 320, 50);
            nextButton.titleLabel.font=[UIFont fontWithName:@"Helvetica" size:32];
            [nextButton setTitle:@"下一关" forState:UIControlStateNormal];
            [nextButton setTitleColor:[UIColor colorWithRed:131.0/255.0 green:169.0/255.0 blue:169.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [nextButton setTitleColor:[UIColor colorWithRed:233.0/255.0 green:66.0/255.0 blue:85.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
            [nextButton addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:nextButton];
        }
    }
    else
    {
        if ([_style isEqualToString:@"闯关模式"]) {
            
            [BmobUtil setRecord:_result type:_style];

            
            UILabel *labelRecord = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 320, 50)];
            labelRecord.backgroundColor = [UIColor clearColor];
            labelRecord.font = [UIFont fontWithName:@"Helvetica" size:20];
            labelRecord.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:labelRecord];
            labelRecord.textColor = [UIColor colorWithRed:233.0/255.0 green:66.0/255.0 blue:85.0/255.0 alpha:1.0];
            labelRecord.text = [NSString stringWithFormat:@"答对了%@道题",_numberCount];
        }
    }
    
//    UIButton *record = [UIButton buttonWithType:UIButtonTypeCustom];
//    record.frame = CGRectMake(0, 270, 320, 40);
//    [record setTitle:@"排行榜" forState:UIControlStateNormal];
//    record.titleLabel.textColor = [UIColor colorWithRed:233.0/255.0 green:66.0/255.0 blue:85.0/255.0 alpha:1.0];
//    [record addTarget:self action:@selector(actionRecord:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:record];

    
    
    FinishView *fView = [[FinishView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-150, 320, 40)];
    [self.view addSubview:fView];
    fView.delegateSelect = self;
    fView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];


  
    
    NSString *isShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShow"];
    if (![isShow isEqualToString:@"0"] || [isShow isEqualToString:@""])
    {
        [self bannerAction];
    }
}


- (IBAction)actionRecord:(id)sender
{

}


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




-(void)nextBtnClick:(UIButton *)buton
{
     NSString *chuangGuanSoure=[[NSUserDefaults standardUserDefaults]objectForKey:@"ChuangGuanScore"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[chuangGuanSoure intValue]+1] forKey:@"ChuangGuanScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
//    UIImage *bgImage2 = [[UIImage alloc]initWithContentsOfFile:savedImagePath];
//    _getImage = bgImage2;
    
    [self actionFen:nil];
//    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    finishBtn.frame = CGRectMake(0, 0, 320, 400);
//    [finishBtn setImage:bgImage2 forState:UIControlStateNormal];
//    [self.view addSubview:finishBtn];

}

#pragma mark - FinishViewDelegate

- (void)doSomething:(FinishView *)fView clickedButton:(UIButton *)button
{
    switch (button.tag) {
        case 1://重来
        {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
            break;
        case 2://返回到主页菜单
        {
            
            LGMainViewController *vc = [[LGMainViewController alloc] init];
            MLNavigationController *nav = [[MLNavigationController alloc] initWithRootViewController:vc];
            nav.navigationBarHidden = YES;
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            
            
            //            [UIView commitAnimations];
        }
            break;
        case 3://分享
        {
//
            
            [self screenShot];
        }
            break;
        default:
            break;
    }
}





- (IBAction)actionFen:(id)sender {
    
    
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
    
//    //发送内容给微信
//    publishContent = [ShareSDK content:_content
//                        defaultContent:_content
//                                 image:[ShareSDK jpegImageWithImage:[UIImage imageWithContentsOfFile:_getImagePath] quality:1]
//                                 title:@"天才帝一步"
//                                   url:_url
//                           description:_content
//                             mediaType:SSPublishContentMediaTypeNews];
    
//    //定制微信好友信息
//    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
//                                         content:contentString
//                                           title:titleString
//                                             url:urlString
//                                      thumbImage:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"icon"]]
//                                           image:[ShareSDK imageWithPath:_getImagePath]
//                                    musicFileUrl:urlString
//                                         extInfo:nil
//                                        fileData:nil
//                                    emoticonData:nil];
    
    
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






/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
