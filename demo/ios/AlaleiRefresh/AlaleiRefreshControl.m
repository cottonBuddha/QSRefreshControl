//
//  AlaleiRefreshControl.m
//  demo
//
//  Created by cottonBuddha on 2017/9/23.
//  Copyright © 2017年 cottonBuddha. All rights reserved.
//

#import "AlaleiRefreshControl.h"
#import "AlaleiIndicator.h"

@implementation AlaleiRefreshControl

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.refreshView = [[AlaleiIndicator alloc] init];
  }
  return self;
}

@end
