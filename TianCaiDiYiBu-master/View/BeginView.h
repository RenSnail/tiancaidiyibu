//
//  BeginView.h
//  wawawa
//
//  Created by ligang on 14-7-11.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import <UIKit/UIKit.h>


@protocol BeginViewDelegate ;

@interface BeginView : UIControl
{
    
    id <BeginViewDelegate> _delegateSelect;

    @private
    UILabel *_labelGo;
    BOOL isChange;
    int count;
    NSTimer *timer;
}

@property (nonatomic,retain)id <BeginViewDelegate> delegateSelect;


- (id)initWithFrame:(CGRect)frame styleStr:(NSString *)style tip:(NSString *)tip point:(NSString *)point;




@end



@protocol BeginViewDelegate <NSObject>

- (void)hide:(BeginView *)beginView;


@end