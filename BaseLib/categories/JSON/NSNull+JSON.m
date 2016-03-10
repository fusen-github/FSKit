//
//  NSNull+Json.m
//  BaseLib
//
//  Created by Kevin Chou on 15-1-28.
//  Copyright (c) 2015年 nowsilence. All rights reserved.
//

#import "NSNull+JSON.h"
#import <objc/runtime.h>

@implementation NSNull (JSON)

- (NSUInteger)length { return 0; }

- (NSInteger)integerValue { return 0; }

- (int) intValue { return 0; }

- (double) doubleValue { return 0; }

- (NSUInteger) unsignedIntegerValue { return 0; }

- (float)floatValue { return 0; };

- (NSString *)description { return @""; }

- (NSArray *)componentsSeparatedByString:(NSString *)separator { return @[]; }

- (id)objectForKey:(id)key { return nil; }

- (BOOL)boolValue { return NO; }

- (NSString *)stringValue
{
    return @"";
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    @synchronized([self class])
    {
        //look up method signature
        NSMethodSignature *signature = [super methodSignatureForSelector:selector];
        if (!signature)
        {
            //not supported by NSNull, search other classes
            static NSMutableSet *classList = nil;
            static NSMutableDictionary *signatureCache = nil;
            if (signatureCache == nil)
            {
                classList = [[NSMutableSet alloc] init];
                signatureCache = [[NSMutableDictionary alloc] init];
                //get class list
                int numClasses = objc_getClassList(NULL, 0);
                Class *classes = (Class *)malloc(sizeof(Class) * (unsigned long)numClasses);
                numClasses = objc_getClassList(classes, numClasses);
                //add to list for checking
                NSMutableSet *excluded = [NSMutableSet set];
                for (int i = 0; i < numClasses; i++)
                {
                    //determine if class has a superclass
                    Class someClass = classes[i];
                    Class superclass = class_getSuperclass(someClass);
                    while (superclass)
                    {
                        if (superclass == [NSObject class])
                        {
                            [classList addObject:someClass];
                            break;
                        }
                        [excluded addObject:NSStringFromClass(superclass)];
                        superclass = class_getSuperclass(superclass);
                    }
                }
                //remove all classes that have subclasses
                for (Class someClass in excluded)
                {
                    [classList removeObject:someClass];
                }
                //free class list
                free(classes);
            }
            //check implementation cache first
            NSString *selectorString = NSStringFromSelector(selector);
            signature = signatureCache[selectorString];
            if (!signature)
            {
                //find implementation
                for (Class someClass in classList)
                {
                    if ([someClass instancesRespondToSelector:selector])
                    {
                        signature = [someClass instanceMethodSignatureForSelector:selector];
                        break;
                    }
                }
                //cache for next time
                signatureCache[selectorString] = signature ?: [NSNull null];
            }
            else if ([signature isKindOfClass:[NSNull class]])
            {
                signature = nil;
            }
        }
        return signature;
    }
}
- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:nil];
}

@end
