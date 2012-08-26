//
//  addOriginalURL.m
//  TurboX
//
//  Created by liuchao on 8/26/12.
//
//

#import "addOriginalURL.h"
#import "XunleiItemInfo.h"
#import "HYXunleiLixianAPI.h"
#import "ScritableApplication.h"

@implementation addOriginalURL

- (id)performDefaultImplementation {
	NSString* originalURL=[self directParameter];
    NSString* xunleiURL=nil;
    HYXunleiLixianAPI *TondarAPI=[HYXunleiLixianAPI new];
    //Add
    if([originalURL hasPrefix:@"magnet"]||[originalURL hasPrefix:@"Magnet"]){
        [TondarAPI addMegnetTask:originalURL];
    }else{
        [TondarAPI addNormalTask:originalURL];
    }
    //获取全部已经完成任务
    for (XunleiItemInfo *task in [TondarAPI readCompleteTasksWithPage:1]) {
        if([task.originalURL isEqualToString:originalURL]){
            //是BT
            if([task.isBT isEqualToString:@"0"]){
               NSMutableArray* btlist=[TondarAPI readAllBTTaskListWithTaskID:task.taskid hashID:task.dcid];
                if(btlist.count==1){
                    xunleiURL=[(XunleiItemInfo*)[btlist objectAtIndex:0] downloadURL];
                }else{
                    [[NSApplication sharedApplication] setBttasklist:btlist];
                }
            }else{
                xunleiURL=task.downloadURL;
            }
            break;
        }
    }

	return xunleiURL;
}

@end
