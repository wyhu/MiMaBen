//
//  CountModel.h
//  MiMaBen
//
//  Created by huweiya on 16/10/14.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountModel : NSObject


/**
 账户
 */
@property (nonatomic, copy) NSString *count;

/**
 账户类型
 */
@property (nonatomic, copy) NSString *countType;


/**
 上次修改时间
 */
@property (nonatomic, copy) NSString *countTime;


/**
 说明
 */
@property (nonatomic, copy) NSString *shuoMing;


/**
 密码
 */
@property (nonatomic, copy) NSString *countPass;



@end
