//
//  TJSourceController.h
//  TJRoutes
//
//  Created by tao on 2018/8/31.
//  Copyright © 2018年 tao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TJExample : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *routeURL;
@property (nonatomic, copy) NSString *routePattern;
@property (nonatomic, assign) SEL selector;

@end

@interface TJSourceController : UITableViewController
@property (nonatomic, strong) NSArray<TJExample *> *examples;

@end
