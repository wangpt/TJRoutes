//
//  UIViewController+TJHelper.h
//  TJRoutes
//
//  Created by tao on 2018/9/22.
//  Copyright © 2018年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TJHelper)
//get topViewController
- (UIViewController *)tj_topViewController;
///kvc
- (void)tj_reflectDataFromNotificationParameters:(NSDictionary *)parameters;
//visible
- (BOOL)tj_isVisible;
@end
