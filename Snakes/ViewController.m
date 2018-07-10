//
//  ViewController.m
//  Snakes
//
//  Created by Li Xiaolei on 2017/6/29.
//  Copyright © 2017年 Li Xiaolei. All rights reserved.
//

#import "ViewController.h"
#import "StakeView.h"
#import "SnakeBody.h"
@interface ViewController ()<StakeDelegate,SnakeMoveDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong) SnakeBody *snakeBody;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (nonatomic,strong) NSMutableArray<UIView*> *foods;
@property(nonatomic,assign) int score;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareFoods];
    StakeView *s = [[StakeView alloc] initWithFrame:CGRectMake(40, [UIScreen mainScreen].bounds.size.height-140, 100, 100)];
    s.delegate = self;
    [self.view addSubview: s];
    _snakeBody = [[SnakeBody alloc] initWithView:self.view];
    _snakeBody.delegate = self;
}

-(void)setScore:(int)score{
    _score = score;
    self.scoreLable.text = [NSString stringWithFormat:@"%d",score];
}
-(void)prepareFoods{
    self.score = 0;
    [self.foods enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.foods removeAllObjects];
    if (!self.foods) {
        self.foods = [NSMutableArray array];
    }
    for (int i =0; i<10; i++) {
        for (int j=0; j<10; j++) {
            int width = arc4random()%11+3;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
            view.backgroundColor = [UIColor colorWithRed:(random()%256)/256.0 green:(random()%256)/256.0 blue:(random()%256)/256.0 alpha:1];
            view.center = CGPointMake(random()%((int)[UIScreen mainScreen].bounds.size.width-30)+15, random()%((int)[UIScreen mainScreen].bounds.size.height-30)+15);
            view.layer.cornerRadius = width/2;
            [self.backView addSubview:view];
            [self.foods addObject:view];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)stakeDidChange:(CGPoint)offset{
    if (offset.x==0&&offset.y==0) {
        return;
    }
    self.snakeBody.side = offset;
}
- (IBAction)clickStart:(UIButton*)sender {
    sender.tag = !sender.tag;
    self.snakeBody.isMoving = sender.tag;
    [sender setTitle:(sender.tag?@"暂停":@"开始") forState:UIControlStateNormal];
}

-(void)snakeDidMove2Frame:(CGRect)rect{
    if (!CGRectContainsRect(self.view.bounds, rect)) {
        //超出边界
        [self restart:nil];
    }
    [self.foods enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //碰撞检测
        if (CGRectContainsPoint(rect, obj.center)) {
            *stop=YES;
            [obj removeFromSuperview];
            [self.foods removeObject:obj];
            self.score+=obj.bounds.size.width/3;
            [self.snakeBody eatFoodCount:obj.bounds.size.width/3];
        }
    }];
}
- (IBAction)restart:(id)sender {
    [self prepareFoods];
    [self.snakeBody reLife];

}

@end
