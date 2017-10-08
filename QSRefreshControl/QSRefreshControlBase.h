//
//  QSRefreshControlBase.h
//  CaiFuPai_swift
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 wangyaqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTComponent.h"
#import "QSRefreshAnimationProtocol.h"

@interface QSRefreshControlBase : UIView
@property (nonatomic,assign) BOOL refreshing;
@property (nonatomic, copy) RCTDirectEventBlock onRefresh;

@property (nonatomic,strong) UIScrollView *subScrollView;
@property (nonatomic,strong) UIView<QSRefreshAnimationProtocol> *refreshView;
@end
