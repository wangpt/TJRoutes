//
//  TJSourceController.m
//  TJRoutes
//
//  Created by tao on 2018/8/31.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "TJSourceController.h"
#import "TJRouterConstHeader.h"
@implementation TJExample

+ (instancetype)exampleWithTitle:(NSString *)title selector:(NSString *)selector routeURL:(NSString *)routeURL routePattern:(NSString *)routePattern{
    TJExample *example = [[self class] new];
    example.title = title;
    example.routeURL = routeURL;
    example.routePattern = routePattern;
    example.selector = NSSelectorFromString(selector);
    return example;
}
@end


@interface TJSourceController ()

@end

@implementation TJSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.examples = @[[TJExample exampleWithTitle:@"Global"
                                         selector:@"globalExample:"
                                         routeURL:@"TJRoutesGlobal://user/view/123"
                                         //等同于TJRouteURLBase(@"user/view/123")
                                     routePattern:@""],
                      [TJExample exampleWithTitle:@"Push"
                                         selector:@"globalExample:"
                                         routeURL:TJPushRouteURL(@"TJDetailController?url=baidu")
                                     routePattern:@""],
                      [TJExample exampleWithTitle:@"Present"
                                         selector:@"globalExample:"
                                         routeURL:TJPresentRouteURL(@"TJDetailController")
                                     routePattern:@""],
                      [TJExample exampleWithTitle:@"Complex"
                                         selector:@"globalExample:"
                                         routeURL:@"TJRoutesComplex://post/edit/123?debug=true&foo=bar"
                                     routePattern:@""],
                      
                      [TJExample exampleWithTitle:@"Schemes1"
                                         selector:@"schemesExample:"
                                         routeURL:@"TJRoutesSchemesThing://foo/view/456"
                                     routePattern:@""],
                      [TJExample exampleWithTitle:@"Schemes2"
                                         selector:@"schemesExample:"
                                         routeURL:@"TJRoutesSchemesStuff://foo/view?user=789"
                                     routePattern:@""],
                      [TJExample exampleWithTitle:@"Schemes3"
                                         selector:@"schemesExample:"
                                         routeURL:@"TJRoutesSchemesThing://foo/view2"
                                     routePattern:@""],
                      
                      [TJExample exampleWithTitle:@"Wildcards"
                                         selector:@"wildcardsExample:"
                                         routeURL:@"TJRoutesWildcards://wildcard/joker?user=111"
                                     routePattern:@""],
                      
                      ];
    
 
}



@end
