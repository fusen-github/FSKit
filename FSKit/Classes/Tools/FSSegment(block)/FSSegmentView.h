//
//  FSSegmentView.h
//
//  Created by 四维图新 on 16/3/25.
//

#import <UIKit/UIKit.h>


typedef void(^FSClickBlock)(NSInteger index);

@interface FSSegmentView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray *)titleArray
                  clickBlick:(FSClickBlock)block;


@end
