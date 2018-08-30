//
//  TJExampleController.m
//  TJRoutes
//
//  Created by tao on 2018/8/30.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "TJExampleController.h"
#import "UITableView+XQUI.h"
#import "TJRouterConstHeader.h"
@interface TJExampleController ()

@end

@implementation TJExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"abcId"];
    //globalRoutes
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abcId" forIndexPath:indexPath];
    cell.textLabel.text = @"push";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView xqui_clearsSelection];
    NSLog(@"调转链接%@",TJPushRouteURL(@"TJNextController"));
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TJPushRouteURL(@"TJNextController")]];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"TJRoutesGlobal://user/view/123"]];

}


@end
