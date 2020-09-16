//
//  UITextField+SPDarkModeSupport.m
//  SPUIKitCategory
//
//  Created by LSP on 2020/9/16.
//  Copyright © 2020 SP. All rights reserved.
//

#import "UITextField+SPDarkModeSupport.h"
#import <objc/runtime.h>

@implementation UITextField (SPDarkModeSupport)

+ (void)load{
    NSArray *originalSelectors = @[@"setTextColor:"];
    
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


#pragma mark - Swizzle Methods
- (void)sp_setTextColor:(UIColor *)textColor {
    
    if (@available(iOS 13.0, *)) {
        UIColor *night = [self darkModeTextColor];
        if (night) {
            textColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) { \
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) { \
                    return night;
                }
                return [textColor resolvedColorWithTraitCollection:traitCollection];
            }];
        }
    } else if (@available(iOS 12.0, *)) {
        UIColor *night = [self darkModeTextColor];
        if (night && [UIApplication sharedApplication].keyWindow.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) { \
            textColor = night;
        }
    }
    
    return [self sp_setTextColor:textColor];
}


#pragma mark - darkModeTextColor
- (UIColor *)darkModeTextColor {
    return objc_getAssociatedObject(self, @selector(darkModeTextColor));
}

- (void)setDarkModeTextColor:(UIColor *)darkModeTextColor {
    objc_setAssociatedObject(self, @selector(darkModeTextColor), darkModeTextColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIColor *normal = self.textColor;
    UIColor *color = normal;
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkModeTextColor;
            }
            return [normal resolvedColorWithTraitCollection:traitCollection];
        }];
    } else if (@available(iOS 12.0, *)) {
        if ([UIApplication sharedApplication].keyWindow.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            color = darkModeTextColor;
        }
    }
    return [self sp_setTextColor:color];
}

@end
