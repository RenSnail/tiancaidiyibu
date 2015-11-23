//
//  SymbolView.h
//  wawawa
//
//  Created by ligang on 14-7-9.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import <UIKit/UIKit.h>


@protocol  SymbolViewDelegate;


@interface SymbolView : UIView
{
    id <SymbolViewDelegate> _delegateSelect;
}

@property (nonatomic,retain)id <SymbolViewDelegate> delegateSelect;


@end



@protocol SymbolViewDelegate <NSObject>

- (void)didSomething:(SymbolView *)scrollViewSelect clickedButton:(UIButton *)button;

@end