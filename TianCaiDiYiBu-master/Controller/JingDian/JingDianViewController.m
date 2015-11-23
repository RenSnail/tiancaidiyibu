//
//  JingDianViewController.m
//  wawawa
//
//  Created by ligang on 14-7-9.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//


#import "JingDianViewController.h"
#import "SymbolView.h"
#import "BeginView.h"
#import "FinishViewController.h"
#import "Algorithm.h"





@interface JingDianViewController ()<SymbolViewDelegate,BeginViewDelegate>
{
    int             _current_OSymobl;//逻辑上的运算符
    UILabel         *_formulationLab;//用于显示表达式
    UILabel         *_labelRest;//用于显示答题数量
    UILabel         *_labelTitle;//用于显示时间
    int             _allIndex;//剩下多少题
    NSTimer         *_timer;//计时器。
}

@end

@implementation JingDianViewController

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
    // Do any additional setup after loading the view
    
    
  
    
    
    
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
    _labelTitle.text = @"0.00";
    BeginView *bView = [[BeginView alloc] initWithFrame:self.view.frame styleStr:@"经典模式" tip:@"在最短的时间内搞定20道题" point:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction

- (IBAction)actionTimer:(id)sender
{
    _labelTitle.text = [NSString stringWithFormat:@"%.2f",[_labelTitle.text floatValue]+0.01];
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
        vc.style = @"经典模式";
        vc.result = @"没搞定!";
        button.alpha=1;
        [self presentViewController:vc animated:YES completion:nil];
        return;
        
    }else{
        
        _current_OSymobl=arc4random()%4;
        [self star];
        _allIndex--;
        
        if (_allIndex == 0) {
            FinishViewController *vc = [[FinishViewController alloc] init];
            vc.style = @"经典模式";
            vc.result = _labelTitle.text;
            button.alpha=1;
            [self presentViewController:vc animated:YES completion:nil];
        }
        _labelRest.text = [NSString stringWithFormat:@"还剩%d道题",_allIndex];
    }
    
}

-(void)star
{
    _current_OSymobl=arc4random()%4;//随机产生0，1，2，3分代表加减乘除4个运算符号。
    CGNum abcNum =[Algorithm getThreeNumber:_current_OSymobl];
    
    _formulationLab.text = [NSString stringWithFormat:@"%d ● %d = %d",abcNum.num1,abcNum.num2,abcNum.num3];
}

@end
