//
//  QSRefreshControlBase.m
//  demo
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import "QSRefreshControl.h"
#import <React/RCTScrollView.h>
#import "RCTScrollView+QSRefresh.h"

#define kNavigationBarHeight 44

@interface QSRefreshControl() <UIScrollViewDelegate>
@property (nonatomic, assign) UIEdgeInsets originInset;
@end

@implementation QSRefreshControl {
    BOOL _initialRefreshingState;
    BOOL _isInitialRender;
    BOOL _currentRefreshingState;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.frame = CGRectMake(0, 0, 0, 0);
    self.triggerDistance = kNavigationBarHeight;
    self.originInset = UIEdgeInsetsZero;
    
    _isInitialRender = YES;
    _currentRefreshingState = NO;
    
    self.followScroll = YES;
  }
  return self;
}

- (void)setRefreshView:(UIView<QSRefreshMotionProtocol> *)refreshView
{
  if (self.refreshView) {
    [self.refreshView removeFromSuperview];
  }
  _refreshView = refreshView;
  [self addSubview:refreshView];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  if ([self.superview isKindOfClass:[UIScrollView class]]) {
    self.subScrollView = (UIScrollView *)self.superview;
    RCTScrollView *reactScrollview = (RCTScrollView *)self.subScrollView.superview;
    if ([reactScrollview respondsToSelector:@selector(addScrollListener:)]) {
      [reactScrollview addScrollListener:self];
    }
    
    CGFloat scrollViewWidth = self.subScrollView.frame.size.width;
    CGFloat refreshViewHeight = self.refreshView.frame.size.height;
    
    if (!self.followScroll) {
      self.frame = CGRectMake(reactScrollview.frame.origin.x, reactScrollview.frame.origin.y, scrollViewWidth, refreshViewHeight);
      [self.subScrollView.rnRefreshView removeFromSuperview];
      reactScrollview.backgroundColor = [UIColor clearColor];
      [reactScrollview.superview insertSubview:self.subScrollView.rnRefreshView belowSubview:reactScrollview];
    } else {
      self.frame = CGRectMake(0, -refreshViewHeight, scrollViewWidth, refreshViewHeight);
      [self.refreshView layoutSubviews];
    }
    
    self.triggerDistance = self.refreshView.triggerDistance ? self.refreshView.triggerDistance : kNavigationBarHeight;
    
    if (!_currentRefreshingState && _isInitialRender && _initialRefreshingState) {
      [self beginRefreshing];
    }
    _isInitialRender = NO;
  }
}

/*
 * 松手前的拖拽
 * 松手后刷新
 * 开始刷新
 * 结束刷新
 * 刷新过程完成回到原点
 */
- (void)draggingBeforeRelease:(CGFloat)offsetY
{
  if ([self.refreshView respondsToSelector: @selector(draggingBeforeReleaseWithOffset:)]) {
    [self.refreshView draggingBeforeReleaseWithOffset:offsetY];
  }
}

- (void)releaseToLoad:(CGFloat)offsetY
{
  if ([self.refreshView respondsToSelector: @selector(draggingBeforeReleaseWithOffset:)]) {

    [self.refreshView draggingBeforeReleaseWithOffset:offsetY];
  }
}

- (void)releaseAndBeginRefreshing
{
  if ([self.refreshView respondsToSelector: @selector(releaseAndBeginRefreshing)]) {
    [self.refreshView releaseAndBeginRefreshing];
  }
}

- (void)stopRefreshingAndBackToOrigin
{
  if ([self.refreshView respondsToSelector: @selector(stopRefreshingAndBackToOrigin)]) {
    [self.refreshView stopRefreshingAndBackToOrigin];
  }
}

- (void)endAll
{
  if ([self.refreshView respondsToSelector: @selector(endAll)]) {
    [self.refreshView endAll];
  }
}

/*
 * scrollview代理的对应代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (!_currentRefreshingState ) {
    if (scrollView.contentOffset.y <= -self.triggerDistance - scrollView.contentInset.top) {
      [self releaseToLoad: -scrollView.contentOffset.y - _originInset.top];
    } else {
      [self draggingBeforeRelease: -scrollView.contentOffset.y - _originInset.top];
    }
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if (scrollView.contentOffset.y <= -self.triggerDistance - scrollView.contentInset.top) {
    [self beginRefreshing];
    if (self.onRefresh) {
      self.onRefresh(nil);
    }
  }
}

/*
 * 刷新
 */
- (void)beginRefreshing
{
  if (!_currentRefreshingState)
  {
    _currentRefreshingState = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
       {
         self.subScrollView.contentInset = UIEdgeInsetsMake(_originInset.top + self.triggerDistance, _originInset.left, _originInset.bottom - self.triggerDistance, _originInset.right);
         [self.subScrollView setContentOffset:CGPointMake(0, -self.subScrollView.contentInset.top) animated:NO];
       } completion:^(BOOL finished) {
         [self releaseAndBeginRefreshing];
      }];
    });
  }
}

/*
 * 刷新结束
 */
- (void)endRefreshing
{
  [self stopRefreshingAndBackToOrigin];
  [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
   {
     self.subScrollView.contentInset = _originInset;
     
   } completion:^(BOOL finished) {
     _currentRefreshingState = NO;
     [self endAll];
   }];
}

- (void)setRefreshing:(BOOL)refreshing
{
  if (!refreshing && _initialRefreshingState) {
    _initialRefreshingState = NO;
  }
  
  if (_currentRefreshingState != refreshing) {
    if (!refreshing) {
      [self endRefreshing];
      return;
    }
    if (_isInitialRender) {
      _initialRefreshingState = refreshing;
    } else {
      [self beginRefreshing];
    }
  }
}

@end
