//
//  CleanCaches.h
//  清理缓存(究极版)
//
//  Created by dllo on 15/10/16.
//  Copyright © 2015年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CleanCaches : NSObject
+(long long)fileSizeAtPath:(NSString *)path;
+(NSString *)folderSizeAtPath;
+(NSString *)cleanCachesAtPath;
@end
