//
//  CountModel.m
//  MiMaBen
//
//  Created by huweiya on 16/10/14.
//  Copyright © 2016年 5i5j. All rights reserved.
//

#import "CountModel.h"

@implementation CountModel


//【安全处理】
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if (!oldValue||[oldValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
        
        if ([oldValue isEqualToString:@"null"]) {
            return @"";
        }
        
    }
    
    return oldValue;
}
@end
