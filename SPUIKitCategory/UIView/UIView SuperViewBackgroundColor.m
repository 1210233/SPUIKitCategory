//
//  UIView+SuperViewBackgroundColor.m
//  SPKitCategory
//
//  Created by LSP on 2020/9/14.
//  Copyright © 2020 lsp. All rights reserved.
//

#import "UIView+SuperViewBackgroundColor.h"
#import <objc/runtime.h>

@implementation UIView (SuperViewBackgroundColor)

+ (void)load{
    NSArray *originalSelectors = @[@"setBackgroundColor:"];
    
    for (NSString *selectorName in originalSelectors) {
        SEL originalSelector = NSSelectorFromString(selectorName);
        SEL swizzledSelector = NSSelectorFromString([@"sp_" stringByAppendingString:selectorName]);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(self,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(self,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
            
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}

- (void)sp_setBackgroundColor:(UIColor *)color {
    
    for (UIView *subview in self.subviews) {
        if (subview.sameBackgroundColorWithSuperview &&
            subview.backgroundColor != [UIColor clearColor]) {
            subview.backgroundColor = color;
        }
    }
    return [self sp_setBackgroundColor:color];
}

- (void)setSameBackgroundColorWithSuperview:(BOOL)sameBackgroundColorWithSuperview {
    objc_setAssociatedObject(self, @selector(sameBackgroundColorWithSuperview), @(sameBackgroundColorWithSuperview), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (sameBackgroundColorWithSuperview) {
        self.backgroundColor = self.superview.backgroundColor;
    }
}

- (BOOL)sameBackgroundColorWithSuperview {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
