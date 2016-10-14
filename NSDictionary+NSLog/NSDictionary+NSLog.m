//
//  NSDictionary+NSLog.m
//  testNSUrl
//
//  Created by 朱公园 on 2016/10/14.
//  Copyright © 2016年 朱公园. All rights reserved.
//

#import "NSDictionary+NSLog.h"

@implementation NSDictionary (NSLog)
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSMutableString * string = [NSMutableString string];
    [string appendString:@"["];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        [string appendFormat:@"%@:",key];
        [string appendFormat:@"%@",obj];
        
    }];
    
    [string appendString:@"]"];
    return string;
    
}

@end
