//
//  LYOperator.m
//  shuaidanbao
//
//  Created by 吴浪 on 15/11/13.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "LYOperator.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation LYOperator

+ (NSString *)currentOperator
{
    NSString *ret = [[ NSString alloc ] init ];
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc ] init ];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (carrier == nil) {
        return @"未知" ;
    }
    NSString *code = [carrier mobileNetworkCode ];
    if ([code  isEqual:@""]) {
        return @"未知" ;
    }
    if ([code isEqualToString:@"00" ] || [code isEqualToString:@"02"] || [code isEqualToString:@"07" ]) {
        ret = @"移动" ;
    }
    
    if ([code isEqualToString:@"01"] || [code isEqualToString:@"06"]) {
        ret = @"联通";
    }
    
    if ([code isEqualToString:@"03"] || [code isEqualToString:@"05"]) {
        
        ret = @"电信" ;
        
    }
    return ret;
}
@end
