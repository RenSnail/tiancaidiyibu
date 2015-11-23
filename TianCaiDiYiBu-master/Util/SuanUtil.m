//
//  SuanUtil.m
//  wawawa
//
//  Created by ligang on 14-7-10.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "SuanUtil.h"

@implementation SuanUtil


+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



@end
