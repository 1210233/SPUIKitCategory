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
    if (self.sameBackgroundColorWithSuperview) {
        [self setSameColorToSubviews:color];
        if (self.backgroundColor == [UIColor clearColor]) {
            return [self sp_setBackgroundColor:[UIColor clearColor]];
        }else{
            return [self sp_setBackgroundColor:color];
        }
    }else{
        return [self sp_setBackgroundColor:color];
    }
}

- (void)setSameColorToSubviews:(UIColor *)color {
    for (UIView *subview in self.subviews) {
           if (subview.sameBackgroundColorWithSuperview) {
               subview.backgroundColor = color;
               [subview setSuperBackgroundColor:color];
           }
       }
}

- (void)setSameBackgroundColorWithSuperview:(BOOL)sameBackgroundColorWithSuperview {
    objc_setAssociatedObject(self, @selector(sameBackgroundColorWithSuperview), @(sameBackgroundColorWithSuperview), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (sameBackgroundColorWithSuperview) {
        self.backgroundColor = self.superBackgroundColor;
    }
}

- (BOOL)sameBackgroundColorWithSuperview {
    return [objc_getAssociatedObject(self, @selector(sameBackgroundColorWithSuperview)) boolValue];
}

- (UIColor *)superBackgroundColor {
    UIColor *color = objc_getAssociatedObject(self, @selector(superBackgroundColor));
    if (!color) {
        color = self.superview.superBackgroundColor;
    }
    if (!color) {
        color = self.backgroundColor;
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
            UIColor *color = self.superview.superBackgroundColor;
            if (self.backgroundColor != [UIColor clearColor]) {
                [self sp_setBackgroundColor:color];
            }
            [self setSameColorToSubviews:color];
        }
    }
    return [self sp_didMoveToSuperview];
}

@end
