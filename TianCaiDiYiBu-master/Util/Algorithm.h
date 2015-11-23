//
//  Algorithm.h
//  wawawa
//
//  Created by ZhangKunYang on 14-7-29.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import <Foundation/Foundation.h>
typedef struct  {
    int num1;
    int num2;
    int num3;
}CGNum;
typedef struct CGNum sumNum;


@interface Algorithm : NSObject
//定义结构体返回三个参数
+(CGNum)getThreeNumber:(int)num1;



@end
