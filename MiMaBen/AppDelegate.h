//
//  AppDelegate.h
//  MiMaBen
//
//  Created by huweiya on 16/8/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



/**
 获取数据数组

 @return 获取数据数组
 */
+ (NSDictionary *)getDataDic;



/**
 获取数据本地路径

 @return 获取数据本地路径
 */
+ (NSString *)getDataPath;

@end

