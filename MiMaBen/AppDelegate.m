//
//  AppDelegate.m
//  MiMaBen
//
//  Created by huweiya on 16/8/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainTabBarController.h"
#import "MainNavigationController.h"
//首页
#import "MainViewController.h"
//设置
#import "SettingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    MainViewController *homeVC = [[MainViewController alloc] init];
//    MainNavigationController *homeNav = [[MainNavigationController alloc] initWithRootViewController:homeVC];
//    
//    SettingViewController *setVC = [[SettingViewController alloc] init];
//    MainNavigationController *setNav = [[MainNavigationController alloc] initWithRootViewController:setVC];
//    
//    MainTabBarController *mainTab = [[MainTabBarController alloc] init];
//    [mainTab addChildViewController:homeNav];
//    [mainTab addChildViewController:setNav];
    
    
//    self.window.rootViewController = mainTab;
//    [self.window makeKeyAndVisible];
    
    ViewController *VC = [[ViewController alloc] init];
    self.window.rootViewController = VC;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [self.window makeKeyAndVisible];
    


}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




+ (NSDictionary *)getDataDic
{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *path=[paths objectAtIndex:0];
    
    
    NSString *filename=[path stringByAppendingPathComponent:@"mainData.plist"];   //获取路径
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    

    return dic;
}


+ (NSString *)getDataPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *path=[paths objectAtIndex:0];
    
    
    NSString *filename=[path stringByAppendingPathComponent:@"mainData.plist"];   //获取路径
    
    return filename;
}


@end
