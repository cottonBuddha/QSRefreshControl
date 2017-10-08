//
//  QSRefreshControlManager.m
//  CaiFuPai_swift
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 wangyaqing. All rights reserved.
//

#import "QSRefreshControlManager.h"
#import "QSRefreshControl.h"

@implementation QSRefreshControlManager
RCT_EXPORT_MODULE();

- (QSRefreshControl *)view
{
    QSRefreshControl *refreshControl = [QSRefreshControl new];
    refreshControl.refreshView;
    return refreshControl;
}

RCT_EXPORT_VIEW_PROPERTY(onRefresh, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(refreshing, BOOL)
@end
