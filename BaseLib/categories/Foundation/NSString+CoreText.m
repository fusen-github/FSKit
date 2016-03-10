//
//  NSString+CoreText.m
//  BaseLib
//
//  Created by Kevin Chou on 14/6/24.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import "NSString+CoreText.h"
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@implementation NSString (CoreText)
- (NSAttributedString *)attributeStringWithFontSize:(int)fontSize lineSpace:(float)lineSpace
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self];
    [string addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:NSMakeRange(0, self.length)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    [string addAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, self.length)];
    
    return string;
}
@end
