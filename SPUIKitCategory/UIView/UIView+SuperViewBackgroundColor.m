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
    NSArray *originalSelectors = @[@"setBackgroundColor:",
                                   @"didMoveToSuperview"];
    
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
    [self setSameColorToSubviews:color];
   
    return [self sp_setBackgroundColor:color];
}

- (void)setSameColorToSubviews:(UIColor *)color {
    for (UIView *subview in self.subviews) {
           if (subview.sameBackgroundColorWithSuperview) {
               [subview setSuperBackgroundColor:color];
               if (subview.backgroundColor != [UIColor clearColor]) {
                   [subview sp_setBackgroundColor:color];
               }
               [subview setSameColorToSubviews:color];
           }
       }
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

- (UIColor *)superBackgroundColor {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    if (!color) {
        color = self.backgroundColor;
    }
    if (!color) {
        color = self.superview.superBackgroundColor;
    }
    if (!color) {
        if (@available(iOS 13.0, *)) {
            color = [UIColor systemBackgroundColor];
        } else {
            color = [UIColor whiteColor];
        }
    }
    return color;
}

- (void)setSuperBackgroundColor:(UIColor *)color {
    objc_setAssociatedObject(self, @selector(superBackgroundColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sp_didMoveToSuperview {
    if (self.superview) {
        if (self.sameBackgroundColorWithSuperview) {
            if (self.backgroundColor != [UIColor clearColor]) {
                [self setBackgroundColor:self.superview.superBackgroundColor];
            }
        }
    }
    return [self sp_didMoveToSuperview];
}

@end
