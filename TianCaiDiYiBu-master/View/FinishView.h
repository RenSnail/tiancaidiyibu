//
//  FinishView.h
//  wawawa
//
//  Created by ligang on 14-7-11.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import <UIKit/UIKit.h>

@protocol  FinishViewDelegate;

@interface FinishView : UIView
{
    id <FinishViewDelegate> _delegateSelect;
    
}

@property (nonatomic,retain)id <FinishViewDelegate> delegateSelect;

@end



@protocol FinishViewDelegate <NSObject>

- (void)doSomething:(FinishView *)fView clickedButton:(UIButton *)button;


@end