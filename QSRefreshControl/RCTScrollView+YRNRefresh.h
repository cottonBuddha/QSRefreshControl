//
//  RCTScrollView+YRTRefresh.h
//  CaiFuPai_swift
//
//  Created by 江齐松 on 2017/5/10.
//  Copyright © 2017年 wangyaqing. All rights reserved.
//

#import "RCTScrollView.h"
#import "YRNRefreshControl.h"

@interface UIScrollView (YRNRefresh)

@property (nonatomic, strong) YRNRefreshControl * rnRefreshView;

@end

@interface RCTScrollView (YRNRefresh)

@end
