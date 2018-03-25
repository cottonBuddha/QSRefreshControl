//
//  RCTScrollView+QSRefresh.m
//  demo
//
//  Created by 江齐松 on 2017/5/10.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import "RCTScrollView+QSRefresh.h"
#import <React/UIView+React.h>
#import <React/RCTAssert.h>
#import <React/RCTUtils.h>
#import <objc/runtime.h>

@implementation UIScrollView (QSRefresh)

/*
 * 下拉刷新
 */
- (void)setRnRefreshView:(QSRefreshControl *)refreshView
{
  objc_setAssociatedObject(self, @selector(rnRefreshView), refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)rnRefreshView
{
  return objc_getAssociatedObject(self, @selector(rnRefreshView));
}

- (void)setRefreshViewControl:(QSRefreshControl *)refreshView
{
  if (self.rnRefreshView) {
    [self.rnRefreshView removeFromSuperview];
  }
  self.rnRefreshView = refreshView;
  [self addSubview:refreshView];
}

@end


@implementation RCTScrollView (QSRefresh)

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    RCTSwapInstanceMethods([self class], @selector(insertReactSubview:atIndex:), @selector(replace_insertReactSubview:atIndex:));
    
    RCTSwapInstanceMethods([self class], @selector(removeReactSubview:), @selector(replace_removeReactSubview:));
  });
}

- (void)replace_insertReactSubview:(UIView *)view atIndex:(NSInteger)atIndex
{
  if ([view isKindOfClass:[QSRefreshControl class]]) {
    [super insertReactSubview:view atIndex:atIndex];
    
    if ([self.scrollView respondsToSelector:@selector(setRefreshViewControl:)]) {
      [self.scrollView performSelector:@selector(setRefreshViewControl:) withObject:view];
    }
  } else {
    [self replace_insertReactSubview:view atIndex:atIndex];
  }
}

- (void)replace_removeReactSubview:(UIView *)subview
{
  if ([subview isKindOfClass:[QSRefreshControl class]]) {
    [super removeReactSubview:subview];
    if ([self.scrollView respondsToSelector:@selector(setRefreshViewControl:)]) {
      [self.scrollView performSelector:@selector(setRefreshViewControl:) withObject:nil];
    }
  } else {
    [self replace_removeReactSubview:subview];
  }
}

@end
