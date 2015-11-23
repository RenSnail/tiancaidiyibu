//
//  SymbolView.m
//  wawawa
//
//  Created by ligang on 14-7-9.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "SymbolView.h"
#import "SuanUtil.h"
@implementation SymbolView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSArray *arrOperationSymbol = @[[UIImage imageNamed:@"symbol1"],[UIImage imageNamed:@"symbol2"],[UIImage imageNamed:@"symbol3"],[UIImage imageNamed:@"symbol4"]];
        
        for (int i = 0 ; i < 4; i ++) {
            UIButton *operationSymbolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i < 2) {
                operationSymbolBtn.frame = CGRectMake(76+64*i+i*40, 3, 64, 64);
            }else{
                operationSymbolBtn.frame = CGRectMake(76+64*(i-2)+(i-2)*40, 103, 64, 64);
            }
            operationSymbolBtn.tag = i+1;
            [operationSymbolBtn setImage:[arrOperationSymbol objectAtIndex:i] forState:UIControlStateNormal];
            [operationSymbolBtn setImage:[arrOperationSymbol objectAtIndex:i] forState:UIControlStateHighlighted];
            [operationSymbolBtn addTarget:self action:@selector(actionSelectionOperationSymbol:) forControlEvents:UIControlEventTouchDown];
            [operationSymbolBtn addTarget:self action:@selector(actionSelectionOperation:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:operationSymbolBtn];
            [operationSymbolBtn addTarget:self action:@selector(actionSelectionOperation:) forControlEvents:UIControlEventTouchDragExit];
            [self addSubview:operationSymbolBtn];
        }
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code.
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 229.0/255.0, 229.0/255.0, 227.0/255.0, 1.0);
    
    //起始点设置为(0,0):注意这是上下文对应区域中的相对坐标，
    CGContextMoveToPoint(context, 70, 85);
    //设置下一个坐标点
    CGContextAddLineToPoint(context, 250, 85);
    
    CGContextMoveToPoint(context, 160, 170);
    CGContextAddLineToPoint(context, 160, 0);
    
    CGContextStrokePath(context);
}


- (IBAction)actionSelectionOperationSymbol:(UIButton *)button
{
    button.alpha=0.35;
    if ([_delegateSelect respondsToSelector:@selector(didSomething:clickedButton:)])
    {
        [_delegateSelect didSomething:self clickedButton:button];
    }
}
-(void)actionSelectionOperation:(UIButton *)button
{
    button.alpha=1;
}
@end
