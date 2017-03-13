//
//  MainViewController.h
//  MiMaBen
//
//  Created by huweiya on 16/8/5.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
//声明
typedef void(^hahaBlock)(NSString *);



@protocol hahaDelegate <NSObject>

- (void)haha:(NSString *)str;

@end



@interface MainViewController : BaseViewController



@property (nonatomic, weak) id<hahaDelegate> hahaDelegate;


@property (nonatomic, strong)  hahaBlock hahaBlock;




@end
