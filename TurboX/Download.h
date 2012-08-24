//
//  Download.h
//  TurboX
//
//  Created by liuchao on 8/23/12.
//  Copyright (c) 2012 Liu Chao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XunleiItemInfo;

@interface Download : NSObject

-(id) initWithGdriveID:(NSString*) gdriveid;
//-(void) downloadWithOriginalURL:(NSString*) urlString;
-(void) downloadWithOriginalURL:(NSString*) originalUrlString XunleiItemInfo:(XunleiItemInfo*) info;

@end
