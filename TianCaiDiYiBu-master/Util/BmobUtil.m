//
//  BmobUtil.m
//  wawawa
//
//  Created by ligang on 14-8-12.
//
//  iOS开发微信公众号：iOSDevTip
//  iOS开发技术网站：http://www.superqq.com/
//

#import "BmobUtil.h"

@implementation BmobUtil


+ (void)setUser
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Chance"];
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
    [bquery whereKey:@"UUID" equalTo:uuid];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error)
        {
            if (array.count > 0)
            {
                
            }
            else
            {
                BmobObject  *gameScore = [BmobObject objectWithClassName:@"Chance"];
                NSString *udid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
                [gameScore setObject:udid forKey:@"UUID"];
                [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful)
                    {
                        
                    }
                    else
                    {
                        
                    }
                }];
            }
            
        }
        else{
            
        }
    }];

}


+ (void)setClick
{
    BmobQuery   *bqueryc = [BmobQuery queryWithClassName:@"DianJi"];
    [bqueryc whereKey:@"UUID" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"]];
    [bqueryc findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {//得到用户的机会对象
        
        if (!error) {
            
            if (array.count > 0)
            {
                BmobObject *oc  = [array objectAtIndex:0];
                NSNumber *numchance = [oc objectForKey:@"count"];
                int chance = [numchance intValue];
                [bqueryc getObjectInBackgroundWithId:oc.objectId block:^(BmobObject *object, NSError *error) {//得到用户的机会对象的机会加10
                    [object setObject:[NSNumber numberWithInt:(chance + 1)] forKey:@"count"];
                    [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {//更新
                        if (isSuccessful) {
                            
                            
                        }
                    }];
                    
                }];

            }
            else
            {
            
                BmobObject  *gameScore = [BmobObject objectWithClassName:@"DianJi"];
                NSString *udid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
                [gameScore setObject:udid forKey:@"UUID"];
                [gameScore setObject:[NSNumber numberWithInt:1] forKey:@"count"];
                [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful)
                    {
                        
                    }
                    else
                    {
                        
                    }
                }];

                
            }
            
        }else{
            
        }
        
    }];
}


+ (void)setRecord:(NSString *)record type:(NSString *)type
{
    BmobQuery   *bqueryc = [BmobQuery queryWithClassName:@"Record"];
    [bqueryc whereKey:@"UUID" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"]];
    [bqueryc whereKey:@"type" equalTo:type];
    [bqueryc findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {//得到用户的机会对象
        
        if (!error) {
            
            if (array.count > 0)
            {
                BmobObject *oc  = [array objectAtIndex:0];
                [bqueryc getObjectInBackgroundWithId:oc.objectId block:^(BmobObject *object, NSError *error) {//得到用户的机会对象的机会加10
                   
                    [object setObject:record forKey:@"record"];
                    [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {//更新
                        if (isSuccessful)
                        {
                            
                        }
                        
                    }];
                    
                }];
                
            }
            else
            {
                
                BmobObject  *gameScore = [BmobObject objectWithClassName:@"Record"];
                NSString *udid = [[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
                [gameScore setObject:udid forKey:@"UUID"];
                [gameScore setObject:record forKey:@"record"];
                [gameScore setObject:type forKey:@"type"];

                [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful)
                    {
                        
                    }
                    else
                    {
                        
                    }
                }];
                
                
            }
            
        }else{
            
        }
        
    }];
}

+ (void)getRecord:(NSString *)type
{
    BmobQuery   *bqueryc = [BmobQuery queryWithClassName:@"Record"];
    [bqueryc whereKey:@"UUID" equalTo:[[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"]];
    [bqueryc whereKey:@"type" equalTo:type];
    [bqueryc findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {//得到用户的机会对象
        
        if (!error) {
            
            if (array.count > 0)
            {
                
            }
            else
            {
                
            }
            
        }else{
            
        }
        
    }];
}




@end
