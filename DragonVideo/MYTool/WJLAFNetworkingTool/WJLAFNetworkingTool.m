//
//  WJLAFNetworkingTool.m
//  OnlineKitchen
//
//  Created by MJ on 16/3/7.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "WJLAFNetworkingTool.h"

#import <AFNetworking.h>


@implementation WJLAFNetworkingTool

+ (void)GETNetWithUrl:(NSString *)url
                 body:(id)body
           headerFile:(NSDictionary *)header
             response:(MJ_LongResponseStyle)responseStyle
              success:(BlockOfSuccess)success
              failure:(void (^)(NSError * error))failure{
    
    // 1.设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    

    
    // 2.设置请求头
    if (header) {
        for (NSString *key in header.allKeys) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    
    // 3.设置返回数据的类型
    switch (responseStyle) {
        case MJ_LongJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case MJ_LongDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case MJ_LongXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    
    
    // 4.设置响应数据的类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    
    // 5.UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    
    path = [path stringByAppendingString:[NSString stringWithFormat:@"/%ld.plist", [url hash]]];
    
    
    // 6.请求数据
    [manager GET:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
  
        if (responseObject) {
            
         [NSKeyedArchiver archiveRootObject:responseObject toFile:path];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            
            id result = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            if (result) {
                success(result);
            }
            
            failure(error);
        }
    }];
}




+ (void)POSTNetWithUrl:(NSString *)url
                  body:(id)body
             bodyStyle:(MJ_LongRequestStyle)bodyRequestStyle
            headerFile:(NSDictionary *)header
              response:(MJ_LongResponseStyle)responseStyle
               success:(BlockOfSuccess)success
               failure:(void (^)(NSError * error))failure{
    
    // 1.设置网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置body体数据类型
    switch (bodyRequestStyle) {
        case MJ_LongRequestJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
            
        case MJ_LongRequestString:
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable * _Nullable error) {
                return parameters;
            }];
            break;
            
        default:
            break;
    }
    
    // 2.设置请求头
    if (header) {
        for (NSString *key in header.allKeys) {
            [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
        }
    }
    
    // 3.设置返回数据的类型
    switch (responseStyle) {
        case MJ_LongJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case MJ_LongDATA:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case MJ_LongXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    // 4.设置响应数据的类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"image/jpeg", @"text/vnd.wap.wml", nil]];
    
    // 5.UTF-8转码
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 6.请求数据
    [manager POST:url parameters:body progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            failure(error);
        }
    }];
}




@end
