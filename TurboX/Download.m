//
//  Download.m
//  TurboX
//
//  Created by liuchao on 8/23/12.
//  Copyright (c) 2012 Liu Chao. All rights reserved.
//


//作废
#import "XunleiItemInfo.h"
#import "Download.h"

@implementation Download
{
    NSString* gdriveid;
}


-(id) initWithGdriveID:(NSString*) gid{
    self=[super init];
    if(self){
        gdriveid=gid;
    }
    return self;
}



/*
-(void) downloadWithOriginalURL:(NSString*) urlString{
    NSTask *task;
    task = [[NSTask alloc] init];
    NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"%@",resourcesPath);
    NSString *exePath = [NSString stringWithFormat:@"%@/aria2c",resourcesPath];
    [task setLaunchPath:exePath];
    NSArray *arguments=nil;
    
    NSString *save_path = @"~/Downloads";
    NSInteger max_thread = 10;
    NSInteger max_speed = 0;
    save_path = [save_path stringByExpandingTildeInPath];
    NSString *max_thread_str = [NSString stringWithFormat:@"%ld", max_thread];
    NSString *max_speed_str = [NSString stringWithFormat:@"%ldK", max_speed];
    
    NSString *cookie=@"Cookie:gdriveid="
    arguments = [NSArray arrayWithObjects:@"--file-allocation=none",@"-c",@"-s",max_thread_str,@"-x",max_thread_str,@"-d",save_path,@"--out",self.TaskTitle, @"--max-download-limit", max_speed_str,@"--header", self.Cookie, self.LiXianURL, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardInput:[NSPipe pipe]];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    NSLog (@"returned:\n%@", string);

}
 */
-(void) downloadWithOriginalURL:(NSString*) originalUrlString XunleiItemInfo:(XunleiItemInfo*) info{
    NSTask *task;
    task = [[NSTask alloc] init];
    NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
    NSLog(@"%@",resourcesPath);
    NSString *exePath = [NSString stringWithFormat:@"%@/aria2c",resourcesPath];
    [task setLaunchPath:exePath];
    NSArray *arguments=nil;
    
    NSString *save_path = @"~/Downloads";
    NSInteger max_thread = 10;
    NSInteger max_speed = 0;
    save_path = [save_path stringByExpandingTildeInPath];
    NSString *max_thread_str = [NSString stringWithFormat:@"%ld", max_thread];
    NSString *max_speed_str = [NSString stringWithFormat:@"%ldK", max_speed];
    
    NSString *cookie=[NSString stringWithFormat:@"Cookie:gdriveid=%@",gdriveid];
    arguments = [NSArray arrayWithObjects:@"--file-allocation=none",@"-c",@"-s",max_thread_str,@"-x",max_thread_str,@"-d",save_path,@"--out",info.name, @"--max-download-limit", max_speed_str,@"--header", cookie,info.downloadURL, nil];
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardInput:[NSPipe pipe]];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    char temp[1024];
    char down[64], total[64], percentage[64], speed[64], lefttime[64];
    
    
    while (1) {
        sleep(1);
        NSData *data = [[[task standardOutput] fileHandleForReading] availableData];
        NSString *errs=[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"%@",errs);
        
        if ([errs rangeOfString:@"error occurred."].location != NSNotFound) {
            break;
        }
        if ([errs rangeOfString:@"Exception caught"].location != NSNotFound) {
            continue;
        }
        if ([errs rangeOfString:@"Download Progress Summary"].location != NSNotFound) {
            continue;
        }
        
        if ([errs length] > 100) {
            continue;
        }
        errs = [errs stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        errs = [errs stringByReplacingOccurrencesOfString:@"/" withString:@" "];
        errs = [errs stringByReplacingOccurrencesOfString:@"(" withString:@" "];
        errs = [errs stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        memset(temp,0,1024*sizeof(char));
        strcpy(temp,[errs cStringUsingEncoding:NSASCIIStringEncoding]);
        sscanf(temp,"%*s SIZE:%s %s %s %*s SPD:%s ETA:%s]", down, total, percentage, speed, lefttime);
        
        NSString *time_left = [NSString stringWithFormat:@"%s", lefttime];
        if ([time_left hasSuffix:@"]"]) {
            time_left = [time_left stringByReplacingOccurrencesOfString:@"]" withString:@""];
        } else {
            time_left = @"";
        }
        
        if (![task isRunning]) {
            break;
        }
    }
    while ([task isRunning]) {
        //DO NOTHING
        //等待程序彻底结束
    }

    switch ([task terminationStatus]) {
            
        case 0:
        {
            //下载完成
            NSLog(@"下载完成！");
        }
            break;
            
        case 7:
        {
            //暂停下载
            NSLog(@"暂停下载");
        }
            break;
            
        default:
            break;
    }
}
@end
