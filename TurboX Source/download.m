//
//  Download.m
//  TurboX
//
//  Created by liuchao on 8/30/12.
//
//

#import "Download.h"
#import "HYXunleiLixianAPI.h"
#import "XunleiItemInfo.h"
#import "Kuai.h"
#import "ASIHTTPRequest.h"

#define LOGIN_USERNAME @"username"
#define LOGIN_PASSWORD @"password"
#define NULLSTRING @"(null)"
#define ISUSERINFOCHECK @"isUserInfoChecked"
#define ORIGINALURL @"originalURL"
#define COOKIE @"cookie"
#define NASIP @"http://192.168.1.222:6800/jsonrpc"

@implementation Download
-(void) downloadToNas:(NSString*) originalURL{
    //GDRIVEID
    NSString* gid=nil;
    HYXunleiLixianAPI *TondarAPI=[HYXunleiLixianAPI new];
    static NSUInteger count=0;
    if([self login]){
        while(!gid&&count<3){
            count++;
            [TondarAPI readCompleteTasksWithPage:1];
            gid=[TondarAPI GDriveID];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:gid forKey:COOKIE];
    
    NSString* xunlei=nil;
    NSString* url=originalURL;
    
    if([url hasPrefix:@"http://kuai.xunlei.com"]||[url hasPrefix:@"kuai.xunlei.com"]){
        Kuai* k=[Kuai new];
        NSArray* kuaiitemArray=[k kuaiItemInfoArrayByKuaiURL:[NSURL URLWithString:url]];
        xunlei=[self addUrlToLixianToNAS:[(KuaiItemInfo*)[kuaiitemArray objectAtIndex:0] urlString]];
    }else{
        xunlei=[self addUrlToLixianToNAS:url];
    }
    

}

#pragma mark - Useful Methods
-(BOOL) login{
    BOOL isCheckLoginInfo=NO;
    static NSUInteger count=0;
    while(!isCheckLoginInfo&&count<3){
        count++;
        NSString* username=[self logininfoFromKeyChain:LOGIN_USERNAME];
        NSString* password=[self logininfoFromKeyChain:LOGIN_PASSWORD];
        if([username isEqualToString:NULLSTRING]||[password isEqualToString:NULLSTRING]){
            [self logininfoFromKeyChain:nil];
            username=[self logininfoFromKeyChain:LOGIN_USERNAME];
            password=[self logininfoFromKeyChain:LOGIN_PASSWORD];
        }
        HYXunleiLixianAPI* TondarAPI=[HYXunleiLixianAPI new];
        if([TondarAPI loginWithUsername:username Password:password]){
            isCheckLoginInfo=YES;
        }else{
            [self logininfoFromKeyChain:nil];
        }
    }
    return isCheckLoginInfo;
}

-(NSString*) logininfoFromKeyChain:(NSString*) key{
    NSTask *task;
    task = [[NSTask alloc] init];
    NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
    NSString *exePath = [NSString stringWithFormat:@"%@/Authenticate.app/Contents/MacOS/Authenticate",resourcesPath];
    [task setLaunchPath:exePath];
    if(key){
        NSArray *arguments=nil;
        if([key isEqualToString:LOGIN_USERNAME]){
            arguments=@[@"-get",@"username"];
        }else if ([key isEqualToString:LOGIN_PASSWORD]){
            arguments=@[@"-get",@"password"];
        }
        
        [task setArguments:arguments];
    }
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *returninfo=[[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return returninfo;
}
-(NSString*) xunleiURL{
    NSString* xunlei=nil;
    NSString* url=[[NSUserDefaults standardUserDefaults] objectForKey:ORIGINALURL];
    
    if([url hasPrefix:@"http://kuai.xunlei.com"]||[url hasPrefix:@"kuai.xunlei.com"]){
        Kuai* k=[Kuai new];
        NSArray* kuaiitemArray=[k kuaiItemInfoArrayByKuaiURL:[NSURL URLWithString:url]];
        xunlei=[self addUrlToLixian:[(KuaiItemInfo*)[kuaiitemArray objectAtIndex:0] urlString]];
    }else{
        xunlei=[self addUrlToLixian:url];
    }
    return xunlei;
}
-(NSString*) addUrlToLixian:(NSString*) url{
    NSString* returnURL=nil;
    HYXunleiLixianAPI *TondarAPI=[HYXunleiLixianAPI new];
    //Add
    NSString* taskdcid=nil;
    if([url hasPrefix:@"magnet"]||[url hasPrefix:@"Magnet"]){
        taskdcid=[TondarAPI addMegnetTask:url];
    }else{
        taskdcid=[TondarAPI addNormalTask:url];
    }
    for (XunleiItemInfo *task in [TondarAPI readCompleteTasksWithPage:1]) {
        if([task.dcid isEqualToString:taskdcid]){
            //BT
            if([task.isBT isEqualToString:@"0"]){
                NSArray* btlist=[TondarAPI readSingleBTTaskListWithTaskID:task.taskid hashID:task.dcid andPageNumber:1];
                long maxsize=0;
                XunleiItemInfo* maxSizeItem=nil;
                for(XunleiItemInfo* bttask in btlist){
                    long currentSize=[bttask.size longLongValue];
                    if(currentSize>maxsize){
                        maxsize=currentSize;
                        maxSizeItem=bttask;
                    }
                }
                returnURL=[maxSizeItem downloadURL];
            }else{
                returnURL=task.downloadURL;
            }
            break;
        }
    }
    return returnURL;
}
-(NSString*) addUrlToLixianToNAS:(NSString*) url{
    NSString* returnURL=nil;
    HYXunleiLixianAPI *TondarAPI=[HYXunleiLixianAPI new];
    //Add
    NSString* taskdcid=nil;
    if([url hasPrefix:@"magnet"]||[url hasPrefix:@"Magnet"]){
        taskdcid=[TondarAPI addMegnetTask:url];
    }else{
        taskdcid=[TondarAPI addNormalTask:url];
    }
    XunleiItemInfo* resultItemInfo=[XunleiItemInfo new];
    for (XunleiItemInfo *task in [TondarAPI readCompleteTasksWithPage:1]) {
        if([task.dcid isEqualToString:taskdcid]){
            //BT
            if([task.isBT isEqualToString:@"0"]){
                NSArray* btlist=[TondarAPI readSingleBTTaskListWithTaskID:task.taskid hashID:task.dcid andPageNumber:1];
                long maxsize=0;
                XunleiItemInfo* maxSizeItem=nil;
                for(XunleiItemInfo* bttask in btlist){
                    long currentSize=[bttask.size longLongValue];
                    if(currentSize>maxsize){
                        maxsize=currentSize;
                        maxSizeItem=bttask;
                    }
                }
                resultItemInfo=maxSizeItem;
            }else{
                resultItemInfo=task;
            }
            break;
        }
    }
    returnURL=resultItemInfo.downloadURL;
    NSString* gdriveid=[[NSUserDefaults standardUserDefaults] objectForKey:COOKIE];
    NSString* cookie=[NSString stringWithFormat:@"\"Cookie: gdriveid=%@;\"",gdriveid];
    NSString* durl=returnURL;
    NSString* name=resultItemInfo.name;
    NSString* nasip=NASIP;
    NSString* json=[NSString stringWithFormat:@"{\"jsonrpc\":\"2.0\", \"id\":\"qwer\",\"method\":\"aria2.addUri\",\"params\":[[\"%@\"],{\"header\":%@,\"out\":\"%@\"}]}",durl,cookie,name];
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:nasip]];
    [request appendPostData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    [request startSynchronous];
    //不成功
    if([request responseStatusCode]!=200){
        returnURL=nil;
    }
    NSLog(@"returnURL:%@",returnURL);
    return returnURL;
}

@end
