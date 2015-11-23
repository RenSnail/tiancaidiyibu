//
//  Algorithm.m
//  wawawa
//
//  Created by ZhangKunYang on 14-7-29.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "Algorithm.h"

@implementation Algorithm
+(CGNum)getThreeNumber:(int)num1
{
    int count = arc4random()%30;
    int c=0;
    int a = arc4random()%50+2;
    int b = arc4random()%50+2;
    //    让a，b大于50的出现几率变小。
    if (count%8 == 0) {
        
        a = arc4random()%100+50;
        
    }else if (count%8 == 1) {
        
        b = arc4random()%100+50;
        
    }
    switch (num1) {
        case 0://代表 加数运算
        {
            if (a==2&&b==2) {
                a=arc4random()%100+3;
            }
            c=a+b;
        }
            break;
        case 1://代表 减数运算
        {
            if ((a==4&&b==2)||(a==2&&b==4)) {
                a+=1;
                b+=1;
            }
            if (a<b) {
                a=a^b;
                b=a^b;
                a=a^b;
            }
            c=a-b;
        }
            break;
        case 2://代表 乘法运算
        {
            a=arc4random()%36+2;
            b=arc4random()%36+2;
            if (a>9)
            {
                //乘数大于9，被乘数要小于等于9
                if (b>9)
                {
                    b=arc4random()%8+2;
                    c=a*b;
                }
                else
                {
                    c=a*b;
                }
            }
            else
            {
                if (a==2&&b==2) {
                    a+=1;
                }
                c=a*b;
            }
        }
            break;
        case 3://代表 除法运算
        {
            while (1){
                //防止4/2=2，a!=4;
                a=arc4random()%250+5;
                NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:0];
                for (int i=2; i<a; i++) {
                    if (a%i==0) {
                        [array addObject:[NSNumber numberWithInt:i]];
                    }
                }
                if ([array count]>0) {
                    
                    b=[[array objectAtIndex:arc4random()%[array count]] integerValue];
                    
                    break;
                }
            }
            c=a/b;
            
        }
            break;
            
        default:
            break;
    }
    CGNum someNums;
    someNums.num1=a;
    someNums.num2=b;
    someNums.num3=c;
    return someNums;
}
@end
