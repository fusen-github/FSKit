//
//  NSString+Extension.h
//  BookReader
//
//  Created by Kevin Chou on 14-6-10.
//  Copyright (c) 2014年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (NSString *)stringWithInt:(int)intNum;
// Checking if String is Empty
-(BOOL)isBlank;

//Checking if String is empty or nil
-(BOOL)isValid;

// remove white spaces from String
- (NSString *)trim;

// If my string contains ony letters
- (BOOL)containsOnlyLetters;

// If my string contains only numbers
- (BOOL)containsOnlyNumbers;

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters;

// Is Valid Email
- (BOOL)isValidEmail;

// Is Valid Phone
- (BOOL)isVAlidPhoneNumber;

// Is Valid URL
- (BOOL)isValidUrl;

// Get My Application Version number
+ (NSString *)getMyApplicationVersion;

// Get My Application name
+ (NSString *)getMyApplicationName;

- (BOOL)checkPhoneNum;

-(BOOL)checkIdentityCardNo;
@end
