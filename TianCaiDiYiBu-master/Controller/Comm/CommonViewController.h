//
//  CommonViewController.h
//  wawawa
//
//  Created by ligang on 14-7-11.
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import <UIKit/UIKit.h>


@interface CommonViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong)UILabel *titleLabel;

@property(strong, nonatomic) UIScrollView *scrollViewCom;


- (void)buttonAction;


@end
