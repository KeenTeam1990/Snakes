//
//  StakeView.h
//  Snakes
//
//  Created by Li Xiaolei on 2017/6/29.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StakeDelegate<NSObject>
@required
-(void)stakeDidChange:(CGPoint)offset;
@end
@interface StakeView : UIView
//提示点偏移量 左下角(-1,-1) 中心点(0,0) 右上角(1，1)
@property (nonatomic,assign) CGPoint offset;
@property (nonatomic,weak)id<StakeDelegate> delegate;
@end
