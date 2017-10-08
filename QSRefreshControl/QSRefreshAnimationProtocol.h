//
//  QSRefreshAnimationProtocol.h
//  CaiFuPai_swift
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 wangyaqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QSRefreshAnimationProtocol <NSObject>
- (void)updateIconWithOffset:(CGFloat)offset;
- (void)beginLoadingAnimation;
- (void)stopLoadingAnimation;
@end
