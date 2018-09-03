//
//  AppDelegate.m
//  TJRoutes
//
//  Created by tao on 2018/8/29.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "AppDelegate.h"
#import "JLRoutes.h"
#import "TJTabBarController.h"
#import <objc/runtime.h>
#import "TJRouterConstHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - helper
/// 获取当前控制器
- (UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}
-(void)paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

#pragma mark - 路由拦截

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSString *str = url.absoluteString;
    NSArray *arr = [str componentsSeparatedByString:@"://"];
    if ([[arr.firstObject lowercaseString] isEqualToString:@"tjroutesschemesthing"]) {
        return [[JLRoutes routesForScheme:@"TJRoutesSchemesThing"]routeURL:url];
    }else if ([[arr.firstObject lowercaseString] isEqualToString:@"tjroutesschemesstuff"]){
        return [[JLRoutes routesForScheme:@"TJRoutesSchemesStuff"]routeURL:url];
    }
    else{
        return NO;
    }

}

#pragma mark - 普通的跳转路由注册
- (void)registerNavgationRouter
{
    //log
    [JLRoutes setVerboseLoggingEnabled:NO];
    // 1.global  多路径
    JLRoutes.globalRoutes[@"/user/view/:userID"] = ^BOOL(NSDictionary *parameters) {
        NSString *userID = parameters[@"userID"];
        NSLog(@"%@",userID);
        return YES;
    };
    // 2.push
    // 路由 /TJPushRoute/:controller
    [[JLRoutes globalRoutes] addRoute:TJPushRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *currentVc = [self currentViewController];
            UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
            [self paramToVc:v param:parameters];
            [currentVc.navigationController pushViewController:v animated:YES];
        });
        return YES;
    }];
    // 3.present
    [[JLRoutes globalRoutes] addRoute:TJPresentRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *currentVc = [self currentViewController];
            UIViewController *v = [[NSClassFromString(parameters[@"controller"]) alloc] init];
            [self paramToVc:v param:parameters];
            [currentVc.navigationController presentViewController:v animated:YES completion:nil];

        });
        return YES;
    }];
    // 4.sb push
    [[JLRoutes globalRoutes] addRoute:TJStoryBoardPushRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        UIViewController *currentVc = [self currentViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:parameters[@"sbname"] bundle:nil];
        UIViewController *v  = [storyboard instantiateViewControllerWithIdentifier:parameters[@"bundleid"]];
        [self paramToVc:v param:parameters];
        [currentVc.navigationController pushViewController:v animated:YES];
        return YES;
    }];
    // 5.complex
    [[JLRoutes globalRoutes] addRoute:@"/:object/:action/:primaryKey" handler:^BOOL(NSDictionary *parameters) {
        NSString *object = parameters[@"object"];
        NSString *action = parameters[@"action"];
        NSString *primaryKey = parameters[@"primaryKey"];
        NSLog(@"%@_%@_%@",object,action,primaryKey);
        return YES;
    }];
}
#pragma mark - Schema 匹配
// routesForScheme 的优先级最高 (注册固定的schemes，则不通知全局的监测)
- (void)registerSchemaRouter
{

    [[JLRoutes routesForScheme:@"TJRoutesSchemesThing"] addRoute:@"/foo/view/:user" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSLog(@"%@",parameters[@"user"]);
        return YES;
    }];
    [[JLRoutes routesForScheme:@"TJRoutesSchemesStuff"] addRoute:@"/foo/view" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSLog(@"%@",parameters[@"user"]);
        return YES;
    }];
/*
    //当这个scheme找不到该路径时,shouldFallbackToGlobalRoutes决定是否进行全局匹配，true为进行再进行全局搜索
    [[JLRoutes routesForScheme:@"TJRoutesSchemesThing"] addRoute:@"/foo/view2" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSLog(@"%@",parameters[@"user"]);
        return YES;
    }];
 */
    [JLRoutes routesForScheme:@"TJRoutesSchemesThing"].shouldFallbackToGlobalRoutes = YES;
    [[JLRoutes globalRoutes] addRoute:@"/foo/view2" handler:^BOOL(NSDictionary *parameters) {
        NSLog(@"TJRoutesSchemesThing");
        return YES;
    }];
    

    
    
}
#pragma mark - wildcards 匹配
- (void)registerWildcardsRouter{
    [[JLRoutes globalRoutes] addRoute:@"/wildcard/*" handler:^BOOL(NSDictionary *parameters) {
        NSArray *pathComponents = parameters[JLRouteWildcardComponentsKey];
        if (pathComponents.count > 0 && [pathComponents[0] isEqualToString:@"joker"]) {
            // 返回路线匹配;
            NSLog(@"%@",parameters[@"user"]);
            return YES;
        }
        // 返回路线不匹配
        return NO;
    }];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [TJTabBarController new];
    
    [self registerNavgationRouter];
    [self registerSchemaRouter];
    [self registerWildcardsRouter];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
