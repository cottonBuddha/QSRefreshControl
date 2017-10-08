//
//  QSRefreshControlBase.m
//  CaiFuPai_swift
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 wangyaqing. All rights reserved.
//

#import "QSRefreshControlBase.h"
#import <React/RCTScrollView.h>

@interface QSRefreshControlBase() <UIScrollViewDelegate>
@property (nonatomic, assign) UIEdgeInsets originInset;
@property (nonatomic, assign) BOOL useCustomNotice;
@property (nonatomic, assign) BOOL isLoadingMore;
@end

@implementation QSRefreshControlBase{
    BOOL _initialRefreshingState;
    BOOL _isInitialRender;
    BOOL _currentRefreshingState;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kNavigationBarHeight);
        
        self.originInset = UIEdgeInsetsZero;
        
        _isInitialRender = true;
        _currentRefreshingState = NO;
        
    }
    return self;
}

- (void)setRefreshView:(UIView<QSRefreshAnimationProtocol> *)refreshView {
    if (_refreshView) {
        [self removeAllSubView];
    }
    
    _refreshView = refreshView;
    [self addSubview:refreshView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        self.subScrollView = (UIScrollView *)self.superview;
        RCTScrollView *reactScrollview = (RCTScrollView *)self.subScrollView.superview;
        if ([reactScrollview respondsToSelector:@selector(addScrollListener:)]) {
            [reactScrollview addScrollListener:self];
        }
        
        if (!_currentRefreshingState && _isInitialRender && _initialRefreshingState) {
            [self refresh];
        }
        _isInitialRender = false;
    }
}


/* 遵守QSRefreshAnimationProtocol
 * 松手前的拖拽
 * 松手后刷新
 * 开始刷新
 * 刷新结束
 */
- (void)draggingBeforeRelease:(CGFloat)offsetY
{
    [self.refreshView updateIconWithOffset:offsetY];
}

- (void)releaseToLoad:(CGFloat)offsetY
{
    [self.refreshView updateIconWithOffset:offsetY];
}

- (void)beginLoading
{
    [self.refreshView beginLoadingAnimation];
}

- (void)loadFinish:(BOOL)success
{
    [self.refreshView stopLoadingAnimation];
}


/*
 * scrollview代理的对应代理方法中调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!_currentRefreshingState ) {
        if (scrollView.contentOffset.y <= -kNavigationBarHeight - scrollView.contentInset.top)
        {
            [self releaseToLoad: -scrollView.contentOffset.y - _originInset.top];
        }
        else
        {
            [self draggingBeforeRelease: -scrollView.contentOffset.y - _originInset.top];
        }
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y <= -kNavigationBarHeight - scrollView.contentInset.top)
    {
        [self refresh];
    }
}

- (void)refresh
{
    if (!_currentRefreshingState)
    {
        _currentRefreshingState = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
             {
                 self.subScrollView.contentInset = UIEdgeInsetsMake(_originInset.top + kNavigationBarHeight,
                                                                    _originInset.left,
                                                                    _originInset.bottom,
                                                                    _originInset.right);
                 [self.subScrollView setContentOffset:CGPointMake(0, -self.subScrollView.contentInset.top) animated:NO];
             } completion:^(BOOL finished) {
                 [self beginLoading];
                 if (self.onRefresh) {
                     self.onRefresh(nil);
                 }
                 
             }];
        });
    }
}

- (void)refreshFinish
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
     {
         self.subScrollView.contentInset = _originInset;
         
         [self loadFinish:YES];
         
     } completion:^(BOOL finished) {
         _currentRefreshingState = NO;
     }];
}

- (void)setRefreshing:(BOOL)refreshing {
    
    if (_currentRefreshingState != refreshing) {
        
        if (refreshing) {
            if (_isInitialRender) {
                _initialRefreshingState = refreshing;
            } else {
                [self refresh];
            }
        } else {
            [self refreshFinish];
        }
    }
}

@end
