//
//  TJDetailController.m
//  TJRoutes
//
//  Created by tao on 2018/8/31.
//  Copyright © 2018年 tao. All rights reserved.
//

#import "TJDetailController.h"

@interface TJDetailController ()

@end

@implementation TJDetailController
- (BOOL)tj_isPresented{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            return NO;
        }else{
            return YES;
        }
    }
    else{
        return YES;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *dissmissLabel = [[UILabel alloc]initWithFrame:UIScreen.mainScreen.bounds];
    [self.view addSubview:dissmissLabel];
    dissmissLabel.text = @"go back";
    dissmissLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self tj_isPresented]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



@end
