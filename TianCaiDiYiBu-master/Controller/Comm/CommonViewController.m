//
//  CommonViewController.m
//  wawawa
//
//  Created by ligang on 14-7-11.
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "CommonViewController.h"
#import "SuanUtil.h"



@interface CommonViewController ()<BOADBannerViewDelegate>


@end

@implementation CommonViewController




- (void)bannerAction
{
    BOADBannerView *bannerView;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        bannerView = [[BOADBannerView alloc] initWithAdSize:BOADAdSizeBanner origin:CGPointMake(0, self.view.frame.size.height  - CGSizeFromBOADAdSize(BOADAdSizeBanner).height)];
    } else {
        bannerView = [[BOADBannerView alloc] initWithAdSize:BOADAdSizeSmartBannerPortrait origin:CGPointMake(0, self.view.frame.size.height  - CGSizeFromBOADAdSize(BOADAdSizeSmartBannerPortrait).height)];
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


//-(void)setBackgroundImage:(UIImage *)backgroundImage{
//    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
//        return;
//    }
//    self.navigationController.navigationBar.layer.contents = (id)backgroundImage.CGImage;
//}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    imgView.userInteractionEnabled=YES;
    [imgView setImage:[SuanUtil createImageWithColor:[UIColor colorWithRed:239.0/255.0 green:62.0/255.0 blue:81.0/255.0 alpha:1.0]]];
    [self.view addSubview:imgView];
    
    UIButton *comeBackBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    comeBackBtn.frame=CGRectMake(5, 2, 40, 40);
    [comeBackBtn setImage:[UIImage imageNamed:@"comeback.png"] forState:UIControlStateNormal];
    [comeBackBtn setImage:[UIImage imageNamed:@"comeback.png"] forState:UIControlStateHighlighted];
    [comeBackBtn addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:comeBackBtn];
    
    _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 2, 160, 40)];
    _titleLabel.font=[UIFont systemFontOfSize:22];
    _titleLabel.textAlignment=1;
    _titleLabel.textColor=[UIColor whiteColor];
    [imgView addSubview:_titleLabel];
    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Helvetica-Bold" size:20],NSFontAttributeName, nil];
//    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
//    [self setBackgroundImage:[SuanUtil createImageWithColor:[UIColor colorWithRed:239.0/255.0 green:62.0/255.0 blue:81.0/255.0 alpha:1.0]]];
//    

    
    NSString *isShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShow"];
    if (![isShow isEqualToString:@"0"] || [isShow isEqualToString:@""])
    {
        [self bannerAction];
    }
    
}


- (void)buttonAction
{
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonBack setBackgroundImage:[UIImage imageNamed:@"back_.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonBack];
    buttonBack.frame = CGRectMake(10, self.view.frame.size.height - 64 - 30, 30, 30);
    [buttonBack addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)actionBack:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
