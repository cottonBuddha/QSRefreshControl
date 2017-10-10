//
//  RCTScrollView+QSRefresh.h
//  demo
//
//  Created by 江齐松 on 2017/5/10.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import <React/RCTScrollView.h>
#import "QSRefreshControl.h"

@interface UIScrollView (QSRefresh)

@property (nonatomic, strong) QSRefreshControl * rnRefreshView;

@end

@interface RCTScrollView (QSRefresh)

@end
