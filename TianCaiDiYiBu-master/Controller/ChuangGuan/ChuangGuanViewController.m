//
//  ChuangGuanViewController.m
//  wawawa
//
//  Created by ZhangKunYang on 14-7-29.
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "ChuangGuanViewController.h"
#import "SymbolView.h"
#import "BeginView.h"
#import "FinishViewController.h"
#import "Algorithm.h"
@interface ChuangGuanViewController ()<SymbolViewDelegate,BeginViewDelegate>
{
    int             _current_OSymobl;//逻辑上的运算符
    UILabel         *_formulationLab;//用于显示表达式
    UILabel         *_labelRest;//用于显示答题数量
    UILabel         *_labelTitle;//用于显示时间
    int             _allIndex;//剩下多少题
    int             _layer;//关数
    NSString        *_layerTime;//每关时长。
    NSTimer         *_timer;//计时器。
}
@property(nonatomic,strong)UIButton *button;
@end

@implementation ChuangGuanViewController

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
    _labelTitle=self.titleLabel;
    
    SymbolView *sView = [[SymbolView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-170-120+44, 320, 170)];
    sView.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0];
    sView.delegateSelect = self;
    [self.view addSubview:sView];
    //显示表达式
    UILabel *formulationLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 90+40, 300, 40)];
    formulationLab.backgroundColor = [UIColor clearColor];
    formulationLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:40];
    formulationLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:formulationLab];
    formulationLab.textColor = [UIColor colorWithRed:104.0/255.0 green:105.0/255.0 blue:108.0/255.0 alpha:1.0];
    _formulationLab = formulationLab;
    
    //答题数
    UILabel *labelRest = [[UILabel alloc] initWithFrame:CGRectMake(10, 40+40, 300, 40)];
    labelRest.backgroundColor = [UIColor clearColor];
    labelRest.text = @"20道题未答";
    labelRest.font = [UIFont fontWithName:@"Helvetica" size:15];
    labelRest.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelRest];
    labelRest.textColor = [UIColor colorWithRed:250.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:1.0];
    _labelRest = labelRest;
    
    [self buttonAction];


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _allIndex = 20;
    NSString *chuangGuan=[[NSUserDefaults standardUserDefaults]objectForKey:@"ChuangGuanScore"];
    NSDictionary *pointDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"points"];
    _layerTime=[pointDict objectForKey:chuangGuan];
    _labelTitle.text = [NSString stringWithFormat:@"%.2f",[_layerTime floatValue]];
    BeginView *bView = [[BeginView alloc] initWithFrame:self.view.frame styleStr:@"闯关模式" tip:[NSString stringWithFormat:@"请在%.2f秒内搞定20道题",[_layerTime floatValue]] point:[NSString stringWithFormat:@"第 %@ 关",chuangGuan]];
    bView.backgroundColor = [UIColor blackColor];
    bView.delegateSelect = self;
    [[UIApplication sharedApplication].keyWindow addSubview:bView];
    [self star];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_timer invalidate];
    _timer=nil;
}
#pragma mark - IBAction

- (IBAction)actionTimer:(id)sender
{
    if ([_labelTitle.text floatValue] != 0.000000) {
       _labelTitle.text = [NSString stringWithFormat:@"%.2f",[_labelTitle.text floatValue]-0.010000];
        if ([_labelTitle.text isEqualToString:@"-0.00"]) {
            _labelTitle.text=@"0.00";
            [_timer invalidate];
            _timer = nil;
        }
    }
    if ([_labelTitle.text isEqualToString:@"0.00"]) {
        _button.alpha=1;
        FinishViewController *fvc=[[FinishViewController alloc]init];
        fvc.style=@"闯关模式";
        fvc.result=@"没搞定!";
        fvc.numberCount=[NSString stringWithFormat:@"%d",20-_allIndex];
        [self presentViewController:fvc animated:YES completion:nil];
    }
}


#pragma mark - BeginViewDelegate

- (void)hide:(BeginView *)beginView
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(actionTimer:) userInfo:nil repeats:YES];
}


#pragma mark - SymbolViewDelegate

- (void)didSomething:(SymbolView *)scrollViewSelect clickedButton:(UIButton *)button
{
    if (_current_OSymobl+1 != button.tag) {
        
        FinishViewController *vc = [[FinishViewController alloc] init];
        vc.style = @"闯关模式";
        vc.result = @"没搞定!";
        vc.numberCount=[NSString stringWithFormat:@"%d",20-_allIndex];
        button.alpha=1;
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        
        _current_OSymobl=arc4random()%4;
        [self star];
        _allIndex--;
        
        if (_allIndex == 0) {
            [_timer invalidate];
            _timer=nil;
            FinishViewController *vc = [[FinishViewController alloc] init];
            vc.style = @"闯关模式";
            vc.result = @"帅呆了!";
            button.alpha=1;
            [self presentViewController:vc animated:YES completion:nil];
        }
        _labelRest.text = [NSString stringWithFormat:@"还剩%d道题",_allIndex];
    }
    _button=button;
}

-(void)star
{
    _current_OSymobl=arc4random()%4;//随机产生0，1，2，3分代表加减乘除4个运算符号。
    CGNum abcNum =[Algorithm getThreeNumber:_current_OSymobl];
    
    _formulationLab.text = [NSString stringWithFormat:@"%d ● %d = %d",abcNum.num1,abcNum.num2,abcNum.num3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
