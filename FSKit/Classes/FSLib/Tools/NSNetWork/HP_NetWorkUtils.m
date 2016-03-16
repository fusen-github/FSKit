//
//  HP_NetWorkUtils.m
//  youyouapp
//
//  Created by Yi Xu on 12-11-30.
//  Copyright (c) 2012年 CuiYiLong. All rights reserved.
//

#import "HP_NetWorkUtils.h"
#import "HP_Reachability.h"
#import <UIKit/UIKit.h>

@implementation HP_NetWorkUtils


+(BOOL)isWifi
{
	return ([[HP_Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == ReachableViaWiFi);
}

+(BOOL)is3G
{
	return ([[HP_Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN);
}

+(BOOL)isNetWorkEnable
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        //NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (NSString *)currentNetWorkStates{
    NSString *state;
    if (![UIApplication sharedApplication].statusBarHidden) { //状态栏没有隐藏
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"] subviews];
        int netType = 0;
        //获取到网络返回码
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                //获取到状态栏
                netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
                
                switch (netType) {
                    case 0:
                        state = @"无网络";
                        //无网模式
                        break;
                    case 1:
                        state = @"2G";
                        break;
                    case 2:
                        state = @"3G";
                        break;
                    case 3:
                        state = @"4G";
                        break;
                    case 5:
                        state = @"WIFI";
                        break;
                    default:
                        state = @"未知网络";
                        break;
                }
            }
        }
    }else {
        HP_Reachability *reach = [HP_Reachability reachabilityWithHostname:@"http://www.baidu.com"];
        switch ([reach currentReachabilityStatus]) {
            case NotReachable:
                state = @"无网络";
                break;
            case ReachableViaWiFi:
                state = @"WIFI";
                break;
            case ReachableViaWWAN:
                state = @"3G";
                break;
            default:
                state = @"未知网络";
                break;
        } ;
    }
    return state;
}
@end
