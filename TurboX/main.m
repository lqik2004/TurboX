//
//  main.m
//  TurboX
//
//  Created by liuchao on 8/23/12.
//  Copyright (c) 2012 Liu Chao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYXunleiLixianAPI.h"
#import "XunleiItemInfo.h"
#import "Download.h"
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSUserDefaults *args = [NSUserDefaults standardUserDefaults];

        NSString* username=[args stringForKey:@"u"];
        NSString* password=[args stringForKey:@"p"];
        NSString* url=[args stringForKey:@"addurl"];

        if(url.length>0&&username.length>0&&password.length>0){
            NSString *cookie=nil;
            NSString *xunleiURL=nil;
            HYXunleiLixianAPI *TondarAPI = [[HYXunleiLixianAPI alloc] init];
            if(![TondarAPI isLogin]){
                [TondarAPI loginWithUsername:username Password:password];
            }
            //Add
            if([url hasPrefix:@"megnet"]||[url hasPrefix:@"Megnet"]){
                [TondarAPI addMegnetTask:url];
            }else{
                [TondarAPI addNormalTask:url];
            }
            //获取全部已经完成任务
            for (XunleiItemInfo *task in [TondarAPI readCompleteTasksWithPage:1]) {
                cookie=[NSString stringWithFormat:@"Cookie:gdriveid=%@",[TondarAPI GDriveID]];
                if([task.originalURL isEqualToString:url]){
                    xunleiURL=task.downloadURL;
                    break;
                }
            }
    NSString *returnString=[NSString stringWithFormat:@" --header %@ %@",cookie,xunleiURL];
    printf("%s",[returnString UTF8String]);
        }
    }
    return 0;
}
