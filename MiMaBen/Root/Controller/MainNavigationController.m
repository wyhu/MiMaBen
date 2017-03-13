//
//  MainNavigationController.m
//  MiMaBen
//
//  Created by huweiya on 16/10/14.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//自动隐藏标签栏
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}



@end
