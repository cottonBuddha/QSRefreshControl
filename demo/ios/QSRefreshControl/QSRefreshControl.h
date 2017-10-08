//
//  QSRefreshControlBase.h
//  demo
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>
#import "QSRefreshMotionProtocol.h"

@interface QSRefreshControl : UIView
@property (nonatomic,assign) BOOL refreshing;
@property (nonatomic,copy) RCTDirectEventBlock onRefresh;
@property (nonatomic,assign) BOOL followScroll;
@property (nonatomic,assign) CGFloat triggerDistance;
@property (nonatomic,weak) UIScrollView *subScrollView;
@property (nonatomic,strong) UIView<QSRefreshMotionProtocol> *refreshView;
@end
