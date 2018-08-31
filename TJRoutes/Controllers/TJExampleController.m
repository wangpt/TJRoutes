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
#import "JLRoutes.h"

static NSString * const kTJCellReuseIdentifier = @"kTJCellReuseIdentifier";
@interface TJExampleController ()

@end

@implementation TJExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return self.examples.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTJCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kTJCellReuseIdentifier];
    }
    TJExample *example = self.examples[indexPath.row];
    cell.textLabel.text = example.title;
    cell.detailTextLabel.text =example.routeURL;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView xqui_clearsSelection];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    TJExample *example = self.examples[indexPath.row];
    [self performSelector:example.selector withObject:example.routeURL];
#pragma clang diagnostic pop

}
- (void)globalExample:(NSString *)path{
    //    NSLog(@"调转链接%@",path);
    [JLRoutes routeURL:[NSURL URLWithString:path]];
    //等同于[[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];

    
}

@end
