//
//  TJRouterConstHeader.h
//  TJRoutes
//
//  Created by tao on 2018/8/29.
//  Copyright © 2018年 tao. All rights reserved.
//
#import <Foundation/Foundation.h>

///需配置schemes
#define TJSCHEMA_ROUTE @"TJRoutesSchemes"
#pragma mark - 路由表

/// 导航栏 Push
FOUNDATION_EXTERN NSString *const TJPushRoute;

/// 导航栏 Present
FOUNDATION_EXTERN NSString *const TJPresentRoute;

/// 导航栏 Push
FOUNDATION_EXTERN NSString *const TJStoryBoardPushRoute;

/// 拼接
NS_INLINE NSString * TJRouteURLBase(NSString *url){
    return [NSString stringWithFormat:@"%@://%@/",TJSCHEMA_ROUTE,url];
}
/// return TJRoutes://TJPushRoute/ + url
NS_INLINE NSString * TJPushRouteURL(NSString *url){
    NSString *string = TJRouteURLBase(@"TJPushRoute");
    return [string stringByAppendingString:url];
}
/// return TJRoutes://TJPresentRoute/ + url
NS_INLINE NSString * TJPresentRouteURL(NSString *url){
    NSString *string = TJRouteURLBase(@"TJPresentRoute");
    return [string stringByAppendingString:url];
}
///  return TJRoutes://TJStoryBoardPushRoute/ + url
NS_INLINE NSString * TJStoryBoardPushRouteURL(NSString *url){
    NSString *string = TJRouteURLBase(@"TJStoryBoardPushRoute");
    return [string stringByAppendingString:url];
}
