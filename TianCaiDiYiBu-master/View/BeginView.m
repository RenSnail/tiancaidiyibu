//
//  BeginView.m
//  wawawa
//
//  Created by ligang on 14-7-11.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "BeginView.h"

@implementation BeginView

- (id)initWithFrame:(CGRect)frame styleStr:(NSString *)style tip:(NSString *)tip point:(NSString *)point
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.alpha = 0.75;
        count=0;
        UILabel *labelStyle = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 50)];
        labelStyle.backgroundColor = [UIColor clearColor];
        labelStyle.text = style;
        labelStyle.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
        labelStyle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelStyle];
        labelStyle.textColor = [UIColor colorWithRed:1.0/255.0 green:254.0/255.0 blue:254.0/255.0 alpha:1.0];
        
        UILabel *labelPoints=[[UILabel alloc]initWithFrame:CGRectMake(0, 140, 320, 50)];
        labelPoints.backgroundColor=[UIColor clearColor];
        labelPoints.text=point;
        labelPoints.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
        labelPoints.textAlignment = NSTextAlignmentCenter;
        labelPoints.textColor = [UIColor colorWithRed:250.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
        [self addSubview:labelPoints];
        
        UILabel *labelTip = [[UILabel alloc] initWithFrame:CGRectMake(0, 205, 320, 50)];
        labelTip.backgroundColor = [UIColor clearColor];
        labelTip.text = tip;
        labelTip.font = [UIFont fontWithName:@"Helvetica" size:15];
        labelTip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelTip];
        labelTip.textColor = [UIColor colorWithRed:250.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
        
        
        UILabel *labelGo = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-145, 320, 50)];
        labelGo.backgroundColor = [UIColor clearColor];
        labelGo.text = @"GO!";
        labelGo.font = [UIFont fontWithName:@"Helvetica" size:40];
        labelGo.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelGo];
        labelGo.textColor = [UIColor colorWithRed:250.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
        _labelGo = labelGo;
        _labelGo.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
        timer =[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(changeAnimations) userInfo:nil repeats:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _labelGo.transform = CGAffineTransformScale(self.transform, 1.8, 1.8);
        [UIView commitAnimations];
    }
    [self addTarget:self action:@selector(actionHide:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return self;
}
-(void)changeAnimations
{
    count++;
    if (count==9) {
        [timer invalidate];
        timer=nil;
        return;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (!isChange&&count!=8) {
        _labelGo.transform = CGAffineTransformScale(self.transform, 0.5, 0.5);
    }
    else if(isChange&&count!=8)
    {
        _labelGo.transform = CGAffineTransformScale(self.transform, 1.8, 1.8);
    }
    else {
        _labelGo.transform = CGAffineTransformScale(self.transform, 1, 1);
    }
    [UIView commitAnimations];
    isChange=!isChange;
    
}
- (IBAction)actionHide:(id)sender
{
    if ([_delegateSelect respondsToSelector:@selector(hide:)]) {
        [_delegateSelect hide:self];
    }
    
    [self removeFromSuperview];
}
@end
