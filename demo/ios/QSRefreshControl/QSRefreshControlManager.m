//
//  QSRefreshControlManager.m
//  demo
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import "QSRefreshControlManager.h"
#import "QSRefreshControl.h"

@implementation QSRefreshControlManager
RCT_EXPORT_MODULE();

- (QSRefreshControl *)view
{
  return [QSRefreshControl new];
}

RCT_EXPORT_VIEW_PROPERTY(onRefresh, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(refreshing, BOOL)

@end
