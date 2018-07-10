//
//  SnakeBody.h
//  Snakes
//
//  Created by Li Xiaolei on 2017/6/29.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SnakeMoveDelegate<NSObject>
-(void)snakeDidMove2Frame:(CGRect)rect;
@end
@interface SnakeBody : NSObject
@property (nonatomic,weak) id<SnakeMoveDelegate> delegate;
@property (nonatomic,assign) CGPoint side;
@property (nonatomic,assign) BOOL isMoving;
@property (nonatomic,weak) UIView *backView;
@property (nonatomic,assign) float nodeWidth;
-(instancetype)initWithView:(UIView*)backView;
-(void)eatFoodCount:(int)count;
-(void)moveForward;
-(void)reLife;
@end
