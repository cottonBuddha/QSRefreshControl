//
//  AlaleiRefreshControlManager.m
//  demo
//
//  Created by cottonBuddha on 2017/9/23.
//  Copyright © 2017年 cottonBuddha. All rights reserved.
//

#import "AlaleiRefreshControlManager.h"
#import "AlaleiRefreshControl.h"

@implementation AlaleiRefreshControlManager
RCT_EXPORT_MODULE();

- (AlaleiRefreshControl*)view
{
  return [AlaleiRefreshControl new];
}

@end
