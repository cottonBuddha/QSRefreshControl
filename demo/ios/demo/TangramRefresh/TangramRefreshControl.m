//
//  TangramRefreshControl.m
//  demo
//
//  Created by cottonBuddha on 2017/9/27.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "TangramRefreshControl.h"
#import "demo-Swift.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation TangramRefreshControl

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.refreshView = [[Tangram alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.5 - 25, 0, 50, 70)];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.refreshView.frame = CGRectMake(self.frame.size.width * 0.5 - 25, 0, 50, 70);
}

@end
