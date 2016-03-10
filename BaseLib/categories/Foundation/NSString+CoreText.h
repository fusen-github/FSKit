//
//  NSString+CoreText.h
//  BaseLib
//
//  Created by Kevin Chou on 14/6/24.
//  Copyright (c) 2014年 nowsilence. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (CoreText)
- (NSAttributedString *)attributeStringWithFontSize:(int)fontSize lineSpace:(float)lineSpace;
@end
