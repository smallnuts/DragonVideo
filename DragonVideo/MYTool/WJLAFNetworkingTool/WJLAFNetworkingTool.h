//
//  WJLAFNetworkingTool.h
//  OnlineKitchen
//
//  Created by MJ on 16/3/7.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ BlockOfSuccess)(id result);

typedef NS_ENUM(NSUInteger, MJ_LongResponseStyle) {
    MJ_LongJSON,
    MJ_LongXML,
    MJ_LongDATA,
};

typedef NS_ENUM(NSUInteger, MJ_LongRequestStyle) {
    MJ_LongRequestJSON,
    MJ_LongRequestString,
    
};

@interface WJLAFNetworkingTool : NSObject

+ (void)GETNetWithUrl:(NSString *)url
                 body:(id)body
           headerFile:(NSDictionary *)header
             response:(MJ_LongResponseStyle)responseStyle
              success:(BlockOfSuccess)success
              failure:(void (^)(NSError * error))failure;


+ (void)POSTNetWithUrl:(NSString *)url
                  body:(id)body
             bodyStyle:(MJ_LongRequestStyle)bodyRequestStyle
            headerFile:(NSDictionary *)header
              response:(MJ_LongResponseStyle)responseStyle
               success:(BlockOfSuccess)success
               failure:(void (^)(NSError * error))failure;


@end
