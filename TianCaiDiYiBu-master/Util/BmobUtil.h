//
//  BmobUtil.h
//  wawawa
//
//  Created by ligang on 14-8-12.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import <Foundation/Foundation.h>

@interface BmobUtil : NSObject



+ (void)setUser;

+ (void)setClick;

+ (void)setRecord:(NSString *)record type:(NSString *)type;

+ (void)getRecord:(NSString *)type;







@end
