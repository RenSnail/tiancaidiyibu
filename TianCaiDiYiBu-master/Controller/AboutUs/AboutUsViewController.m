//
//  GuanYuViewController.m
//  ShaiGongZi
//
//  Created by ligang on 14-7-31.
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "AboutUsViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <AGCommon/UIDevice+Common.h>



@interface AboutUsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_mutArrValue;
    UITableView *_tableView;
    
}

@end

@implementation AboutUsViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"关于我们";

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    _mutArrValue = [NSMutableArray arrayWithObjects:@"关注新浪官方微博",@"微信公众账号：iOSDevTip",@"QQ交流群：303868520",[NSString stringWithFormat:@"版本更新    %@",nowVersion],@"去下载", nil];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height-44-100) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    _tableView = tableView;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark UITableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _mutArrValue.count;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIndentifier = [NSString stringWithFormat:@"CellIndentifier"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [_mutArrValue objectAtIndex:indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if (indexPath.section == 1 || indexPath.section == 2) {
        cell.detailTextLabel.text = @"点击复制关注";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];

    }
    
    
//    cell.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:102.0/255.0 blue:123.0/255.0 alpha:1.0];
    
    return cell;
    
}





#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
        {
            [self actionGuanZhu:nil];
        }
            break;

        case 1:
        {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = @"iOSDevTip";
            
            [self showHint:@"恭喜! 复制成功"];
        }
            break;
        case 2:
        {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = @"303868520";
            
            [self showHint:@"恭喜! 复制成功"];
        }
            break;
        case 3:
        {
            
            
            
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
            
            
            BmobQuery   *bquery1 = [BmobQuery queryWithClassName:@"UD"];
            [bquery1 findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (!error && array.count != 0) {
                    BmobObject *o = [array objectAtIndex:0];
                    NSLog(@"%@",[o objectForKey:@"need"]);
                    if (![[o objectForKey:@"need"] isEqualToString:nowVersion]) {
                        
                        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"URL"] isEqualToString:@""]) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://pgyer.com/KDco"]];
                        }else{
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"URL"]]];
                        }
                        
                    }else{
                        [self showHint:@"当前就是最新版本！"];
                    }
                }
                
            }];

        }
            break;
        case 4:
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"URL"] isEqualToString:@""]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://pgyer.com/KDco"]];
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"URL"]]];
            }
        }
            break;
            
        default:
            break;
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE5) {
        return 40;

    }else{
        return 30;

    }
}




- (IBAction)actionBanBen:(id)sender
{
    int count = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NewVersion"] length];
   
    if (count == 0) {
        [self showHint:@"当前就是最新版本！"];
    }
    else
    {
        
        
        
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"Version"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"NewVersion"]])
        {
            BmobQuery   *bquery = [BmobQuery queryWithClassName:@"XiaZai"];
            [bquery orderByDescending:@"createdAt"];
            bquery.limit = 1;
            bquery.skip = 1;
            [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                
                if (!error && array.count != 0) {
                    BmobObject *o = [array objectAtIndex:0];
                    NSURL *url = [NSURL URLWithString:[o objectForKey:@"URL"]];
                    [[UIApplication sharedApplication]openURL:url];
                }
            }];
        }
        else
        {
            NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=722630093"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0];
            [NSURLConnection connectionWithRequest:request delegate:self];
        }
    }
    

}


- (IBAction)actionFuZhiQQ:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"303868520";
    
    [self showHint:@"恭喜! 复制成功"];
}


- (IBAction)actionFuZhi:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"iOSDevTip";
    
    [self showHint:@"恭喜! 复制成功"];

}





- (IBAction)actionGuanZhu:(id)sender
{
    
    
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"李刚移动"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"李刚移动"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    [ShareSDK followUserWithType:ShareTypeSinaWeibo
                           field:@"李刚移动"
                       fieldType:SSUserFieldTypeName
                     authOptions:authOptions
                    viewDelegate:nil
                          result:^(SSResponseState state, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                              
                              NSString *msg = nil;
                              if (state == SSResponseStateSuccess)
                              {
                                  msg = @"关注成功";
                              }
                              else if (state == SSResponseStateFail)
                              {
                                  msg = [NSString stringWithFormat:@"关注失败:%@", error.errorDescription];
                              }
                              
                              if (msg)
                              {
                                  [self showHint:msg];

                              }
                          }];

}


- (IBAction)actionBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}






@end
