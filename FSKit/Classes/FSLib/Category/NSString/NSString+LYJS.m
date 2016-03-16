//
//  NSString+LYJS.m
//  shuaidanbao
//
//  Created by 吴浪 on 15/11/17.
//  Copyright © 2015年 sdb. All rights reserved.
//

#import "NSString+LYJS.h"
@implementation NSString (LYJS)
/** javascript false=取消超链接 true=恢复超链接
 function doLinkAll(action) {
    var aLabels = document.getElementsByTagName("a");
    for (var i = 0; i < aLabels.length; i++) {
        if (action) {
           if (aLabels[i].rel) {
              aLabels[i].setAttribute("href", aLabels[i].ref);
           }
        }else {
           aLabels[i].setAttribute("rel", aLabels[i].href);
           aLabels[i].removeAttribute("href");
        }
    }
 }
 */
+ (NSString *)jsForbidLink:(BOOL)flag {
    NSString *jsFlag;
    if (flag) {
        jsFlag = @"false";
    }else {
        jsFlag = @"true";
    }
    NSString *js = [NSString stringWithFormat:@"function doLinkAll(action) { var aLabels = document.getElementsByTagName('a'); for (var i = 0; i < aLabels.length; i++) { if (action) { if (aLabels[i].rel) { aLabels[i].setAttribute('href', aLabels[i].ref); } }else { aLabels[i].setAttribute('rel', aLabels[i].href); aLabels[i].removeAttribute('href'); } } } doLinkAll(%@);", jsFlag];
    return js;
}

+ (NSString *)jsForbidCopy {
    NSString *js = @"document.documentElement.style.webkitUserSelect='none';";
    return js;
}

+ (NSString *)jsForbidMenu {
    NSString *js = @"document.documentElement.style.webkitTouchCallout='none';";
    return js;
}

+ (NSString *)jsScrollToTop {
    NSString *js = @"window.scrollTo(0, 0);";
    return js;
}

- (NSDictionary *)paramsFromURL {
    
    NSString *protocolString = [self substringToIndex:([self rangeOfString:@"://"].location)];
    
    NSString *tmpString = [self substringFromIndex:([self rangeOfString:@"://"].location + 3)];
    NSString *hostString = nil;
    
    if (0 < [tmpString rangeOfString:@"/"].length) {
        hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"/"].location)];
    }
    else if (0 < [tmpString rangeOfString:@"?"].length) {
        hostString = [tmpString substringToIndex:([tmpString rangeOfString:@"?"].location)];
    }
    else {
        hostString = tmpString;
    }
    
    tmpString = [self substringFromIndex:([self rangeOfString:hostString].location + [self rangeOfString:hostString].length)];
    NSString *uriString = @"/";
    if (0 < [tmpString rangeOfString:@"/"].length) {
        if (0 < [tmpString rangeOfString:@"?"].length) {
            uriString = [tmpString substringToIndex:[tmpString rangeOfString:@"?"].location];
        }
        else {
            uriString = tmpString;
        }
    }
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (0 < [self rangeOfString:@"?"].length) {
        NSString *paramString = [self substringFromIndex:([self rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0]
                                 stringByRemovingPercentEncoding];
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByRemovingPercentEncoding];
                [pairs setObject:value forKey:key];
            }
        }
    }
    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            pairs, PARAMS,
            protocolString, PROTOCOL,
            hostString, HOST,
            uriString, URI, nil];
}
@end
