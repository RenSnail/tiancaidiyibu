//
//  ChanViewController.m
//  wawawa
//
//  Created by ZhangKunYang on 14-7-29.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "ChanViewController.h"
#import "FinishViewController.h"
#import "SymbolView.h"
#import "BeginView.h"
#import "Algorithm.h"
@interface ChanViewController ()<SymbolViewDelegate,BeginViewDelegate>
{
    int             _current_OSymobl;//逻辑上的运算符
    UILabel         *_formulationLab;//用于显示表达式
    UILabel         *_labelRest;//用于显示答题数量
    int             _allIndex;//剩下多少题
    NSTimer         *_timer;//计时器。
}
@property(nonatomic,strong)UILabel *labelTitle;//用于显示时间
@property(nonatomic,strong)UIButton *btn;//控制按钮alpha
@end

@implementation ChanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    labelRest.text = @"一个问题也没有完成";
    labelRest.font = [UIFont fontWithName:@"Helvetica" size:15];
    labelRest.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelRest];
    labelRest.textColor = [UIColor colorWithRed:250.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:1.0];
    _labelRest = labelRest;
    
    [self buttonAction];

    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_timer invalidate];
    _timer=nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _allIndex = 0;
    _labelTitle.text = @"20.00";
    BeginView *bView = [[BeginView alloc] initWithFrame:self.view.frame styleStr:@"禅模式" tip:@"20秒内尽可能抢答更多的题" point:nil];
    bView.backgroundColor = [UIColor blackColor];
    bView.delegateSelect = self;
    [[UIApplication sharedApplication].keyWindow addSubview:bView];
    [self star];
}
- (IBAction)actionTimer:(id)sender
{
   
    if ([_labelTitle.text floatValue]!=0.000000) {
        _labelTitle.text = [NSString stringWithFormat:@"%.2f",[_labelTitle.text floatValue]-0.010000];
        if ([_labelTitle.text isEqualToString:@"-0.00"]) {
            _labelTitle.text=@"0.00";
            //时间没有的时候，不再调用定时器
            [_timer invalidate];
            _timer=nil;
        }
    }
    if ([_labelTitle.text isEqualToString:@"0.00"]) {
        _btn.alpha=1;
        FinishViewController *vc = [[FinishViewController alloc] init];
        vc.style = @"禅模式";
        vc.result = [NSString stringWithFormat:@"%d",_allIndex];
        [self presentViewController:vc animated:YES completion:nil];
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
        vc.style = @"禅模式";
        vc.result = [NSString stringWithFormat:@"%d",_allIndex];
        button.alpha=1;
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    else{
        
        _current_OSymobl=arc4random()%4;
        [self star];
        _allIndex++;
        _labelRest.text = [NSString stringWithFormat:@"答对了%d道题",_allIndex];
    }
    _btn=button;
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
    
}

@end