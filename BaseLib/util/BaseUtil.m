//
//  KCUtil.m
//  BaseLib
//
//  Created by Kevin Chou on 14/6/24.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "BaseUtil.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation BaseUtil


+ (int)hexToDecimal:(int)hexInt;
{
    NSString *hexStr = [NSString stringWithFormat:@"0x%d",hexInt];
    
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    
    unsigned int ret;
    
    [scanner scanHexInt:&ret];
    
    return ret;
}

+ (NSString *)convertFloatToString:(float)value
{
    NSString *valueStr = [NSString stringWithFormat:@"%f",value];
    
    for (NSInteger i = valueStr.length - 1; i >= 0; i--)
    {
        NSString *tmp = [valueStr substringWithRange:NSMakeRange(i, 1)];
        
        if ([tmp intValue] > 0)
        {
            return [valueStr substringToIndex:i + 1 < valueStr.length ? i + 1 : i];
        }
        else if([tmp isEqualToString:@"."])
        {
            return [valueStr substringToIndex:i > 0 ? i : 0];
        }
    }
    
    return valueStr;
}

+ (int)getAttributedStringHeight:(NSAttributedString *)string width:(int)width
{
    int h = 10000; //[string length] * 40;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string); //string为要计算高度的NSAttributedString
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, width, h)); //这里的高要设置足够大
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray* linesArray = (NSArray*)CTFrameGetLines(textFrame);
    NSUInteger count = [linesArray count];
    if(count <= 0) {
        CFRelease(textFrame);
        return 0;
    }
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    CGFloat line_y = origins[count - 1].y; //最后一行line的原点y坐标
    
    CGFloat ascent, descent, leading;
    CTLineRef line = (__bridge CTLineRef)[linesArray objectAtIndex: [linesArray count] - 1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat total_height = h - line_y + ascent + descent + leading + 1; //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    return total_height;
}

+ (NSInteger)getYearOfDate:(NSDate *)date
{
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit fromDate:currentDate]; // Get necessary date components
   
    return [components year];
}

+ (NSString *)formatDate:(NSDate *)date format:(NSString *)format
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式format
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    return [dateFormatter stringFromDate:date];
//    //输出格式为：2010-10-27 10:22:13
//    NSLog(@"%@",currentDateStr);
//    //alloc后对不使用的对象别忘了release
//    [dateFormatter release];
}

+ (NSString*)_UDID_iOS7
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}


#pragma mark -
#pragma mark Helper Method for Get Mac Address

// from http://stackoverflow.com/questions/677530/how-can-i-programmatically-get-the-mac-address-of-an-iphone
+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = nil;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        if (msgBuffer) {
            free(msgBuffer);
        }
        
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

@end
