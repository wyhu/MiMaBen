//
//  MainTabBarController.m
//  MiMaBen
//
//  Created by huweiya on 16/10/14.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
//设置swift

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad { 
    // Do any additional setup after loading the view.
    
    MainViewController *homeVC = [[MainViewController alloc] init];
    
    MainNavigationController *homeNav = [[MainNavigationController alloc] initWithRootViewController:homeVC];
    
    SettingViewController *setVC = [[SettingViewController alloc] init];
    
    MainNavigationController *setNav = [[MainNavigationController alloc] initWithRootViewController:setVC];
    
    self.viewControllers = @[homeNav,setNav];
    
    NSArray *titleArr = @[@"首页",@"设置"];
    
    for (int i = 0; i < titleArr.count; i++) {
        
        UITabBarItem *tabBarItem = self.tabBar.items[i];
        
        tabBarItem.title = titleArr[i];
        
        
    }
    
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
