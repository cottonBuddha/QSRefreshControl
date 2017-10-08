//
//  TangramRefreshControlManager.m
//  demo
//
//  Created by cottonBuddha on 2017/9/27.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "TangramRefreshControlManager.h"
#import "TangramRefreshControl.h"

@implementation TangramRefreshControlManager
RCT_EXPORT_MODULE();

- (TangramRefreshControl*)view
{
  return [TangramRefreshControl new];
}

@end
