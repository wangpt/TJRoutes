//
//  UIViewController+TJHelper.m
//  TJRoutes
//
//  Created by tao on 2018/9/22.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "UIViewController+TJHelper.h"
#import <objc/runtime.h>

@implementation UIViewController (TJHelper)
- (UIViewController *)tj_topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        if ([self tj_isVisible]) {
            return vc;
        }else{
            return nil;
        }
    }
    return nil;
}

- (BOOL)tj_isVisible {
    return [self isViewLoaded] && self.view.window;
}

- (void)tj_reflectDataFromNotificationParameters:(NSDictionary *)parameters{
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(self.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        NSString *propertyValue = parameters[propertyName];
        if (propertyValue != nil) {
            [self setValue:propertyValue forKey:propertyName];
        }
    }
}

@end
