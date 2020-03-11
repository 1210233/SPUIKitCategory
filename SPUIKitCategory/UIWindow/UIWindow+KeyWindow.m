//
//  UIWindow+KeyWindow.m
//  HeartHeart
//
//  Created by LSP on 15/7/3.
//  Copyright (c) 2015年 LSP. All rights reserved.
//

#import "UIWindow+KeyWindow.h"

static UITableView *reportTableView;
__weak UIView *reportView;
@implementation UIWindow (KeyWindow)
+ (instancetype)window{
    return [UIApplication sharedApplication].keyWindow;
}

@end
