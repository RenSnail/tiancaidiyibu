//
//  main.m
//  wawawa
//
//  Created by ZhangKunYang on 14-7-7.
//  Copyright (c) 2014年 ZhangKunYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    
    [Bmob registerWithAppKey:@"7bcd617cdf2e7d1ba5945d95f6fa5615"];

    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
