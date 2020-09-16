//
//  UIView+SPDarkModeSupport.m
//  SPUIKitCategory
//
//  Created by LSP on 2020/9/14.
//  Copyright © 2020 lsp. All rights reserved.
//

#import "UIView+SPDarkModeSupport.h"
#import <objc/runtime.h>

@implementation UIView (SPDarkModeSupport)

+ (void)load{
    NSArray *originalSelectors = @[@"setBackgroundColor:",
                                   @"didMoveToSuperview" //,
                                   //@"traitCollectionDidChange:"
                                   ];
    
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
- (void)sp_setBackgroundColor:(UIColor *)color {
    
    if (@available(iOS 13.0, *)) {
        UIColor *night = [self darkModeBackgroundColor];
        if (night) {
            color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                    return night;
                }
                return [color resolvedColorWithTraitCollection:traitCollection];
            }];
        }
    } else if (@available(iOS 12.0, *)) {
        UIColor *night = [self darkModeBackgroundColor];
        if (night && [UIApplication sharedApplication].keyWindow.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            color = night;
        }
    }
    
    
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


#pragma mark - Setters & Getters
#pragma mark sameBackgroundColorWithSuperview
- (BOOL)sameBackgroundColorWithSuperview {
    return [objc_getAssociatedObject(self, @selector(sameBackgroundColorWithSuperview)) boolValue];
}

- (void)setSameBackgroundColorWithSuperview:(BOOL)sameBackgroundColorWithSuperview {
    objc_setAssociatedObject(self, @selector(sameBackgroundColorWithSuperview), @(sameBackgroundColorWithSuperview), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (sameBackgroundColorWithSuperview) {
        self.backgroundColor = self.superBackgroundColor;
    }
}


#pragma mark superBackgroundColor
- (void)setSuperBackgroundColor:(UIColor *)color {
    objc_setAssociatedObject(self, @selector(superBackgroundColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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


#pragma mark darkModeBackgroundColor
- (UIColor *)darkModeBackgroundColor {
    return objc_getAssociatedObject(self, @selector(darkModeBackgroundColor));
}

- (void)setDarkModeBackgroundColor:(UIColor *)darkModeBackgroundColor {
    objc_setAssociatedObject(self, @selector(darkModeBackgroundColor), darkModeBackgroundColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    UIColor *normal = self.backgroundColor;
    UIColor *color = normal;
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkModeBackgroundColor;
            }
            return [normal resolvedColorWithTraitCollection:traitCollection];
        }];
    } else if (@available(iOS 12.0, *)) {
        if ([UIApplication sharedApplication].keyWindow.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            color = darkModeBackgroundColor;
        }
    }
    return [self sp_setBackgroundColor:color];
}

#pragma mark - Function Methods
- (void)setSameColorToSubviews:(UIColor *)color {
    for (UIView *subview in self.subviews) {
        if (subview.sameBackgroundColorWithSuperview) {
            subview.backgroundColor = color;
            [subview setSuperBackgroundColor:color];
        }
    }
}

- (void)sp_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    self.layer.color
    return [self sp_traitCollectionDidChange:previousTraitCollection];
}

@end
