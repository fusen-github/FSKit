//
//  NCRadioGroup.m
//  CheckBox
//
//  Created by Nigel Chou on 16/3/3.
//  Copyright (c) 2016年 BeautyFuture. All rights reserved.
//

#import "NCRadioGroup.h"

@interface NCRadioGroup()

@property(nonatomic,strong) NSMutableArray *boxes;

@property(nonatomic,strong) NCCheckBox *checkedBox;
@end

@implementation NCRadioGroup
{
    NSMutableArray *_boxes;
}

- (void)addCheckBox:(NCCheckBox *)checkBox, ...
{
    NSMutableArray *array = [NSMutableArray array];
    
    va_list params;
    
    va_start(params,checkBox);
    
    id box;
    
    if (checkBox)
    {
        [array addObject:checkBox];

        while( (box = va_arg(params,id)) )
        {
            if ( box ){
                [array addObject:box];
            }
        }

        va_end(params);
    }
    
    for (NCCheckBox *_box in array) {
        
        [_box addTarget:self action:@selector(boxClicked:) forControlEvents:UIControlEventValueChanged];
    }
    
    
    [self.boxes addObjectsFromArray:array];
}

- (void)boxClicked:(NCCheckBox *)box
{
    [self valueChanged:box];

    if (self.delegate && [self.delegate respondsToSelector:@selector(radioGroup:valueChanged:atIndex:)])
    {
        [self.delegate radioGroup:self valueChanged:box atIndex:[self.boxes indexOfObject:box]];
    }
}

- (void)valueChanged:(NCCheckBox *)box
{
    if (self.checkedBox != box) {
        
        if (self.checkedBox) {
            
            self.checkedBox.selected = NO;
        }
        
        self.checkedBox = box;
        
        box.selected = YES;
    }
}

- (void)setSelectedIndex:(NSInteger)index
{
    if (index < self.boxes.count) {
        
        NCCheckBox *box = [self.boxes objectAtIndex:index];
        
        [self valueChanged:box];
    }
}

- (NSInteger)selectedIndex
{
    if (self.checkedBox) {
        
        return [self.boxes indexOfObject:self.checkedBox];
    }
    
    return -1;
}

- (NSMutableArray *)boxes
{
    if(_boxes) {
        
        return _boxes;
    }
    
    _boxes = [NSMutableArray array];
    
    return _boxes;
}
@end
