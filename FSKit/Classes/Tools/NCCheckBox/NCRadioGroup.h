//
//  NCRadioGroup.h
//  CheckBox
//
//  gitHub:https://github.com/nowsilence/uiDemo/tree/master/CheckBox
//
//  Created by Nigel Chou on 16/3/3.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NCCheckBox.h"

@class NCRadioGroup;

@protocol NCRadioGroupDelegate <NSObject>

@optional

- (void)radioGroup:(NCRadioGroup *)radioGroup valueChanged:(NCCheckBox *)box atIndex:(NSInteger)index;

@end

@interface NCRadioGroup : NSObject

@property(nonatomic,weak) id<NCRadioGroupDelegate> delegate;

@property(nonatomic) NSInteger selectedIndex;

- (void)addCheckBox:(NCCheckBox *)checkBox, ...;

@end
