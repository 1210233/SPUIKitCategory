//
//  UIFont+FastCreate.m
//  SmartCity
//
//  Created by LSP on 2017/5/19.
//  Copyright © 2017年 LSP. All rights reserved.
//

#import "UIFont+FastCreate.h"

@implementation UIFont (CircleFastCreate)

+ (instancetype)regularPingFangOfSize:(CGFloat)size {
    UIFont *font = [self fontWithName:@"PingFangSC-Regular" size:size];
    return font ? font : [UIFont systemFontOfSize:size];
}
+ (instancetype)mediumPingFangOfSize:(CGFloat)size {
    UIFont *font = [self fontWithName:@"PingFangSC-Medium" size:size];
    return font ? font : [UIFont systemFontOfSize:size];
}
+ (instancetype)boldPingFangOfSize:(CGFloat)size {
    UIFont *font = [self fontWithName:@"PingFangSC-Semibold" size:size];
    return font ? font : [UIFont boldSystemFontOfSize:size];
}

@end
