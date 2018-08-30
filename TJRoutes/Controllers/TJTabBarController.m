//
//  TJTabBarController.m
//  TJRoutes
//
//  Created by tao on 2018/8/30.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "TJTabBarController.h"
#import "TJNavigationController.h"

@interface TJTabBarModel: NSObject
@property (nonatomic, strong)NSString *controller;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *image;
@end

@implementation TJTabBarModel
+ (instancetype)tabbarWithController:(NSString *)controller title:(NSString *)title image:(NSString *)image{
    TJTabBarModel *model = [TJTabBarModel new];
    model.controller = controller;
    model.title = title;
    model.image = image;
    return model;
}

@end

@interface TJTabBarController ()
@end

@implementation TJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray * sources = @[
                          [TJTabBarModel tabbarWithController:@"TJExampleController" title:@"综合" image:@"tabbar-news"],
                          [TJTabBarModel tabbarWithController:@"TJDemoController" title:@"发现" image:@"tabbar-discover"]
                          ];
    [self setUpRootViewControllers:sources];
    self.tabBar.tintColor = [UIColor colorWithRed:91.0/255.0 green:166.0/255.0 blue:54.0/255.0 alpha:1.0];
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor grayColor];
    } else {
        // Fallback on earlier versions
        self.tabBar.barTintColor = [UIColor grayColor];
    }
}

- (void)setUpRootViewControllers:(NSArray *)sources{
    NSMutableArray *controllers = @[].mutableCopy;
    [sources enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TJTabBarModel *model = obj;
        Class class = NSClassFromString(model.controller);
        UIViewController *controller = [class new]?:[UIViewController new];
        TJNavigationController *navi = [[TJNavigationController alloc]initWithRootViewController:controller];
        controller.title = model.controller;
        [controllers addObject:navi];
    }];
    self.viewControllers = controllers;
    //item
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        TJTabBarModel *model = sources[idx];
        [item setTitle:model.title];
        item.image = [[UIImage imageNamed:model.image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[model.image stringByAppendingString:@"-selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
