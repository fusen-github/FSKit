//
//  KCDES.h
//  DES
//
//  Created by Kevin Chou on 14-2-18.
//  Copyright (c) 2014年 Kevin Chou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDES : NSObject

+ (NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key;
+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key;
@end
