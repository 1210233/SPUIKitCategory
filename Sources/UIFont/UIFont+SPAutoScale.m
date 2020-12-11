//
//  UIFont+SPAutoScale.m
//  SPUIKitCategory
//
//  Created by LSP on 2020/9/25.
//  Copyright © 2020 1210233. All rights reserved.
//

#import "UIFont+SPAutoScale.h"
#import <objc/runtime.h>

@implementation UIFont (SPAutoScale)

- (void)setAutoscaled:(BOOL)autoscaled {
    objc_setAssociatedObject(self, "autoscaled", @(autoscaled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)autoscaled {
    return [objc_getAssociatedObject(self, "autoscaled") boolValue];
}

@end

