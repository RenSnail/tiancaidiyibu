//
//  FinishView.m
//  wawawa
//
//  Created by ligang on 14-7-11.
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "FinishView.h"

@implementation FinishView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSArray *arrOperationSymbol = @[[UIImage imageNamed:@"again"],[UIImage imageNamed:@"back"],[UIImage imageNamed:@"share"]];
        
        NSArray *arrTip = @[@"重来",@"返回",@"炫耀"];
        
        for (int i = 0 ; i < 3; i ++) {
            UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            finishBtn.frame = CGRectMake(50*(i+1)+40*i, 0, 40, 40);
            finishBtn.tag = i+1;
            [finishBtn setImage:[arrOperationSymbol objectAtIndex:i] forState:UIControlStateNormal];
            [finishBtn setImage:[arrOperationSymbol objectAtIndex:i] forState:UIControlStateHighlighted];
            [finishBtn addTarget:self action:@selector(actionFinish:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:finishBtn];
            
            UILabel *labelGo = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 40, 40)];
            labelGo.backgroundColor = [UIColor clearColor];
            labelGo.text = [arrTip objectAtIndex:i];
            labelGo.font = [UIFont fontWithName:@"Helvetica" size:15];
            labelGo.textAlignment = NSTextAlignmentCenter;
            [finishBtn addSubview:labelGo];
            labelGo.textColor = [UIColor grayColor];
        }
    }
    return self;
}


- (IBAction)actionFinish:(UIButton *)sender
{
    if ([_delegateSelect respondsToSelector:@selector(doSomething:clickedButton:)]) {
        [_delegateSelect doSomething:self clickedButton:sender];
    }
}

@end
