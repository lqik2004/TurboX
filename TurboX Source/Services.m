//
//  Services.m
//  TurboX
//
//  Created by liuchao on 8/30/12.
//
//

#import "Services.h"
#import "Download.h"


@implementation Services
-(void)xunleiDownload:(NSPasteboard*) pboard  userData:(NSString *)data
                error:(NSString **)error{
    NSString *pboardString;
    NSArray *types;
    
    types = [pboard types];
    
    if (![types containsObject:NSStringPboardType] || !(pboardString = [pboard stringForType:NSStringPboardType])) {
        *error = NSLocalizedString(@"Error: Pasteboard doesn't contain a string.",
                                   @"Pasteboard couldn't give string.");
        return;
    }
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    // Get and encrypt the string.
    
    Download *download=[Download new];
    NSString* url=@"ed2k://%7Cfile%7C特伦鲍姆一家.The.Royal.Tenenbaums.2001.BD-RMVB-人人影视原创翻译中英双语字幕.rmvb%7C517775905%7C00842f399271776b35ac6c0ee8d15962%7Ch=tdmjhekewu7zn7dvpyqizjo4ewgogpnt%7C";
    [download downloadToNas:url];
    return;
}

-(void) xunleiToNAS:(NSPasteboard*) pboard userData:(NSString*) data
              error:(NSString **) error{
    // Test for strings on the pasteboard.
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    // Get and encrypt the string.
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    
    Download *download=[Download new];
    NSString* url=@"ed2k://%7Cfile%7C特伦鲍姆一家.The.Royal.Tenenbaums.2001.BD-RMVB-人人影视原创翻译中英双语字幕.rmvb%7C517775905%7C00842f399271776b35ac6c0ee8d15962%7Ch=tdmjhekewu7zn7dvpyqizjo4ewgogpnt%7C";
    [download downloadToNas:url];
    return;
}
@end
