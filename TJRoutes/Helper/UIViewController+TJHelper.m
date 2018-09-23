//
//  UIViewController+TJHelper.m
//  TJRoutes
//
//  Created by tao on 2018/9/22.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "UIViewController+TJHelper.h"

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
@end
