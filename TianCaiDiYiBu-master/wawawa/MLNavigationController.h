//
//  MLNavigationController.h
//  MultiLayerNavigation
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//



#import <UIKit/UIKit.h>

@interface MLNavigationController : UINavigationController

// Enable the drag to back interaction, Defalt is YES.
@property (nonatomic,assign) BOOL canDragBack;
@property (nonatomic,assign) BOOL isMoving;

- (void)changeSupportedInterfaceOrientations:(UIInterfaceOrientationMask)interfaceOrientation;



@end
