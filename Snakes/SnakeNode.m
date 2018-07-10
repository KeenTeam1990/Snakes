//
//  SnakeNode.m
//  Snakes
//
//  Created by Li Xiaolei on 2017/6/29.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#import "SnakeNode.h"

@implementation SnakeNode
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = frame.size.width/2;
    }
    return self;
}

-(void)setCenter:(CGPoint)center{
    [super setCenter:center];
       self.backgroundColor = [UIColor colorWithRed:center.x/[UIScreen mainScreen].bounds.size.width green:1-center.x/[UIScreen mainScreen].bounds.size.width blue:center.y/[UIScreen mainScreen].bounds.size.height alpha:1];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
