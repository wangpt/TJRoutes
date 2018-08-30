//
//  UITableView+XQUI.m
//  XQUIKit
//
//  Created by tao on 2018/8/22.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "UITableView+XQUI.h"

@implementation UITableView (XQUI)
- (void)xqui_clearsSelection {
    NSArray<NSIndexPath *> *selectedIndexPaths = [self indexPathsForSelectedRows];
    for (NSIndexPath *indexPath in selectedIndexPaths) {
        [self deselectRowAtIndexPath:indexPath animated:YES];
    }
}
@end
