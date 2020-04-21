//
//  UIView+XIBCreation.m
//  SmartCity
//
//  Created by LSP on 2017/5/12.
//  Copyright © 2017年 LSP. All rights reserved.
//

#import "UIView+XIBCreation.h"

@implementation UIView (XIBCreation)

+ (instancetype)loadFromNib {
    return [self loadFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)loadFromNibWithName:(NSString *)nibName {
    return [self loadFromNibWithName:nibName owner:nil];
}

+ (instancetype)loadFromNibWithName:(NSString *)nibName owner:(id)owner {
    return [self loadFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}

+ (instancetype)loadFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle {
    NSArray* array = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id obj in array) {
        if ([obj isKindOfClass:[self class]]) {
            return obj;
        }
    }
    return nil;
}

@end
