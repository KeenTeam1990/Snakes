//
//  StakeView.m
//  Snakes
//
//  Created by Li Xiaolei on 2017/6/29.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#import "StakeView.h"
@interface StakeView()
//中间的提示点
@property (nonatomic,strong) UIView *tipView;
//直径
@property (nonatomic,assign) CGFloat diameter;
//初始位置
@property (nonatomic,assign) CGPoint orgCenter;
@end
@implementation StakeView
-(instancetype)initWithFrame:(CGRect)frame{
    //以w,h最小值为宽高，保持正方形
    self.diameter = frame.size.width>frame.size.height?frame.size.height:frame.size.width;
    frame.size.width = self.diameter;
    frame.size.height = self.diameter;
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = true;
        self.orgCenter = self.center;
        self.layer.cornerRadius = self.diameter/2;
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.tipView];
        self.offset = CGPointZero;
    }
    return self;
}

-(void)setOffset:(CGPoint)offset{
    if (NAN==offset.x||NAN==offset.y) {
        return;
    }
    _offset = offset;
    self.tipView.center = CGPointMake(offset.x*_diameter/2+_diameter/2, offset.y*_diameter/2+_diameter/2);
    [self.delegate stakeDidChange:offset];
}

-(UIView *)tipView{
    if (!_tipView) {
        _tipView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.diameter/3, self.diameter/3)];
        _tipView.backgroundColor = [UIColor darkGrayColor];
        _tipView.layer.cornerRadius = self.diameter/6;
    }
    return _tipView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    self.center = [t locationInView:self.superview];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self];
    //计算相对于中心点的位置
    p.x-=(self.diameter/2);
    p.y-=(self.diameter/2);
    //直线距离
    CGFloat s = sqrt(p.x*p.x+p.y*p.y);
    //与半径的倍数
    CGFloat ts = s/(self.diameter/2);
    if (ts>1) {
        p.x/=ts;
        p.y/=ts;
    }
    p.x/=(self.diameter/2);
    p.y/=(self.diameter/2);
    self.offset = p;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.center = self.orgCenter;
    self.offset = CGPointZero;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.center = self.orgCenter;
    self.offset = CGPointZero;
}

@end
