/*
     File: SimpleApplication.m 
 Abstract: For our application scripting class, we have
 implemented the properties as element accessors in a
 category of NSApplication. This file contains the
 interface for that. 
  Version: 1.2 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2011 Apple Inc. All Rights Reserved. 
  
 */ 


#import "SimpleApplication.h"
#import "scriptLog.h"
#import "download.h"
#import "HYXunleiLixianAPI.h"
#import "XunleiItemInfo.h"

#define LOGIN_USERNAME @"username"
#define LOGIN_PASSWORD @"password"
#define NULLSTRING @"(null)"
#define ISUSERINFOCHECK @"isUserInfoChecked"
#define ORIGINALURL @"originalURL"

@implementation NSApplication (scriptable)

bool isCheckLoginInfo=NO;
-(NSString*) gdriveid{
    HYXunleiLixianAPI *TondarAPI=[HYXunleiLixianAPI new];
    if([self login]){
        [TondarAPI readCompleteTasksWithPage:1];
    }
    return [TondarAPI GDriveID];
}

-(BOOL) login{
    static NSUInteger count=0;
    isCheckLoginInfo=NO;
    while(!isCheckLoginInfo||count<3){
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

- (NSString*) specialVersion {
	NSString *theResult = @"1.0";
	return theResult;
}

-(NSString*) originalURL{
    return @"OriginalURL";
}
-(void) setOriginalURL:(NSString *)originalURL{
    [[NSUserDefaults standardUserDefaults] setObject:originalURL forKey:ORIGINALURL];
}

-(NSString*) xunleiURL{
    NSString* xunlei=nil;
    NSString* url=[[NSUserDefaults standardUserDefaults] objectForKey:ORIGINALURL];
    HYXunleiLixianAPI *TondarAPI=[HYXunleiLixianAPI new];
    //Add
    if([url hasPrefix:@"megnet"]||[url hasPrefix:@"Megnet"]){
        [TondarAPI addMegnetTask:url];
    }else{
        [TondarAPI addNormalTask:url];
    }
    //获取全部已经完成任务
    for (XunleiItemInfo *task in [TondarAPI readCompleteTasksWithPage:1]) {
        if([task.originalURL isEqualToString:url]){
            xunlei=task.downloadURL;
            break;
        }
    }
    return xunlei;
}
@end

