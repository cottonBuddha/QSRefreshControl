//
//  QSRefreshAlalei.m
//  demo
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import "AlaleiIndicator.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

typedef enum : NSUInteger {
    AlaleiEnter,
    AlaleiQuit,
} AlaleiStageType;

@interface AlaleiIndicator()
@property (nonatomic,strong) UILabel* offsetLabel;
@property (nonatomic,strong) UIImageView* alaleiRun;
@property (nonatomic,strong) UIImageView* backImage;
@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,assign) AlaleiStageType alaleiStageType;

@end

@implementation AlaleiIndicator

- (instancetype)init
{
    self = [super init];
    if (self) {
      NSLog(@"当前的线程%@",[NSThread currentThread]);
      self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
      self.backgroundColor = [UIColor colorWithRed:0 green:204/255.f blue:153/255.f alpha:1];
      self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
      [self.backImage setImage:[UIImage imageNamed:@"back"]];
      [self addSubview:self.backImage];
      _alaleiRun = [[UIImageView alloc] initWithFrame:CGRectMake(-180, 0, 210, 70)];
      
      _alaleiRun.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"alalei0"],
                                    [UIImage imageNamed:@"alalei1"],
                                    [UIImage imageNamed:@"alalei2"],
                                    [UIImage imageNamed:@"alalei3"], nil];
      _alaleiRun.animationDuration = 0.4;
      _alaleiRun.animationRepeatCount = 0;
      [_alaleiRun startAnimating];
      
      _alaleiRun.backgroundColor = [UIColor greenColor];
      
      [self addSubview:_alaleiRun];
      
      self.offsetLabel = [[UILabel alloc] initWithFrame:self.bounds];
      self.offsetLabel.textAlignment = NSTextAlignmentCenter;
      
      self.isLoading = NO;
      self.alaleiStageType = AlaleiEnter;
      self.triggerDistance = 100;
    }
    return self;
}

- (void)alaleiRunViewChangeWithValue:(CGFloat)value
{
    CGFloat limitValue = value < 70 ? value : 70;
    CGFloat v = (kScreenWidth * 0.5 + 180)/70;
    if (self.alaleiStageType == AlaleiEnter) {
      CGPoint center = CGPointMake(limitValue * v - 210, _alaleiRun.center.y);
      _alaleiRun.center = center;
    } else {
//      CGFloat x = (70 - limitValue) * v + kScreenWidth * 0.5 - 105;
//      CGPoint center = CGPointMake(x, _alaleiRun.center.y);
//      _alaleiRun.center = center;
//      _alaleiRun.frame = CGRectMake(kScreenWidth + 210, 0, 210, 70);
    }
}

/*
 * 实现QSRefreshMotionProtocol
 */
- (void)draggingBeforeReleaseWithOffset:(CGFloat)offset
{
  [self alaleiRunViewChangeWithValue:offset];
}

- (void)releaseAndBeginRefreshing
{
  [self alaleiRunViewChangeWithValue:self.triggerDistance];
}

- (void)stopRefreshingAndBackToOrigin
{
  [UIView animateWithDuration:0.5 animations:^{
    _alaleiRun.frame = CGRectMake(kScreenWidth + 210, 0, 210, 70);
  } completion:^(BOOL finished) {
    self.alaleiRun.frame = CGRectMake(-180, 0, 210, 70);
  }];
}

- (void)endAll
{
  //nothing
}

@end
