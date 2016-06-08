//
//  CleanCaches.m
//  清理缓存(究极版)
//
//  Created by dllo on 15/10/16.
//  Copyright © 2015年 MJ. All rights reserved.
//

#import "CleanCaches.h"

@implementation CleanCaches
//计算单个文件大小
+(long long)fileSizeAtPath:(NSString *)path
{
    NSFileManager *manage = [NSFileManager defaultManager];
    if ([manage fileExistsAtPath:path]) {
        return [[manage attributesOfItemAtPath:path error:nil]fileSize];
    }
    return 0;
}
//计算文件夹里所有文件大小
+(NSString *)folderSizeAtPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"caches"];
    NSFileManager *manage = [NSFileManager defaultManager];
    if (![manage fileExistsAtPath:path]) {
        return 0;
    }
    NSEnumerator *enumerator = [[manage subpathsAtPath:path] objectEnumerator];
    NSString *fileName = [NSString string];
    float fileSize = 0;
    while ((fileName = [enumerator nextObject]) != nil) {
        NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
        fileSize += [self fileSizeAtPath:absolutePath];
    }
    return [NSString stringWithFormat:@"%.2fM", fileSize / (1024.0 * 1024.0)];
}
//清除文件夹里文件
+(NSString *)cleanCachesAtPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"caches"];
    NSLog(@"%@", path);
    NSFileManager *manage = [NSFileManager defaultManager];
    if ([manage fileExistsAtPath:path]) {
        NSArray *fileNameArray = [manage subpathsAtPath:path];
        for (NSString *fileName in fileNameArray) {
             NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [manage removeItemAtPath:absolutePath error:nil];
        }
    }
    return [self folderSizeAtPath];
}

@end
