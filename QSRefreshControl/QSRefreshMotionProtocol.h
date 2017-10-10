//
//  QSRefreshMotionProtocol.h
//  demo
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QSRefreshMotionProtocol <NSObject>

- (void)draggingBeforeReleaseWithOffset:(CGFloat)offset;
- (void)releaseAndBeginRefreshing;
- (void)stopRefreshingAndBackToOrigin;
- (void)endAll;
- (CGFloat)triggerDistance;

@end
