//
//  QSRefreshAlalei.h
//  demo
//
//  Created by 江齐松 on 2017/8/14.
//  Copyright © 2017年 江齐松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSRefreshMotionProtocol.h"
@interface AlaleiIndicator : UIView<QSRefreshMotionProtocol>
@property (nonatomic,assign) CGFloat triggerDistance;

@end
