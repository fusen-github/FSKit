//
//  FSSegmentView.m
//
//  Created by 四维图新 on 16/3/25.
//

#import "FSSegmentView.h"

@interface FSSegmentView ()


#define ScreenWidth  ([[UIScreen mainScreen] bounds].size.width)

#define SFQRedColor [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]

#define MAX_TitleNumInWindow 5

@property (nonatomic,strong) NSMutableArray *btns;

@property (nonatomic,strong) NSArray *titles;

@property (nonatomic,strong) UIButton *titleBtn;

@property (nonatomic,strong) UIScrollView *bgScrollView;

@property (nonatomic,strong) UIView *selectLine;

@property (nonatomic,assign) CGFloat btn_w;

@property (nonatomic,copy) FSClickBlock block;

/********   如果需要修改按钮的一些属性，可以考虑修改下面几个属性       *******/

@property (nonatomic,strong) UIColor *titleNomalColor;

/**
 *  选中时的文字颜色,默认红色
 */
@property (nonatomic,strong) UIColor *titleSelectColor;

/**
 *  字体大小，默认15
 */
@property (nonatomic,strong) UIFont  *titleFont;

/**
 *  默认选中的index=0，即第一个
 */
@property (nonatomic,assign) NSInteger defaultIndex;

@end

@implementation FSSegmentView

-(instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray *)titleArray
                  clickBlick:(FSClickBlock)block
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _btn_w = 0.0;
        
        if (titleArray.count < MAX_TitleNumInWindow + 1)
        {
            _btn_w = ScreenWidth / titleArray.count;
            
        }
        else
        {
            _btn_w= ScreenWidth / MAX_TitleNumInWindow;
        }
        _titles=titleArray;
        
        _defaultIndex = 0;
        
        _titleFont = [UIFont systemFontOfSize:15];
        
        _btns = [[NSMutableArray alloc] initWithCapacity:0];
        
        _titleNomalColor = [UIColor darkTextColor];
        
        _titleSelectColor = SFQRedColor;
        
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
        
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        
        _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count, self.frame.size.height);
        
        [self addSubview:_bgScrollView];
        
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, _btn_w*titleArray.count, 1)];
        
        line.backgroundColor=[UIColor lightGrayColor];
        
        [_bgScrollView addSubview:line];
        
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, _btn_w, 2)];
        
        _selectLine.backgroundColor=_titleSelectColor;
        
        [_bgScrollView addSubview:_selectLine];
        
        for (int i=0; i<titleArray.count; i++)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            
            btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, self.frame.size.height-2);
            
            btn.tag=i+1;
            
            [btn setTitle:titleArray[i] forState:UIControlStateNormal]
            ;
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [btn setBackgroundColor:[UIColor whiteColor]];
            
            btn.titleLabel.font=_titleFont;
            
            [_bgScrollView addSubview:btn];
            
            [_btns addObject:btn];
            
            if (i==0)
            {
                _titleBtn=btn;
                
                btn.selected=YES;
            }
            self.block = block;
        }
    }
    
    return self;
}


-(void)btnClick:(UIButton *)btn
{
    if (self.block)
    {
        self.block(btn.tag);
    }
    
    if (btn.tag == _defaultIndex)
    {
        return;
    }
    else
    {
        _titleBtn.selected=!_titleBtn.selected;
        
        _titleBtn=btn;
        
        _titleBtn.selected = YES;
        
        _defaultIndex = btn.tag;
    }
    
    CGFloat offsetX=btn.frame.origin.x - 2 * _btn_w;
    
    if (offsetX < 0)
    {
        offsetX = 0;
    }
    CGFloat maxOffsetX = _bgScrollView.contentSize.width - ScreenWidth;
    
    if (offsetX > maxOffsetX)
    {
        offsetX = maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
        _selectLine.frame = CGRectMake(btn.frame.origin.x, self.frame.size.height-2, btn.frame.size.width, 2);
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
