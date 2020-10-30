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
    NSArray *originalSelectors = @[@"setBackgroundColor:"
                                   , @"addSubview:"
                                   , @"didMoveToSuperview"
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
    self.originalBackgroundColor = color;

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


    [self setSuperBackgroundColorToSubviews:color];
    return [self sp_setBackgroundColor:color];
}
- (void)sp_didMoveToSuperview {
    if (self.superview) {
        if (self.sameBackgroundColorWithSuperview) {
            [self setSuperBackgroundColor:self.superBackgroundColor];
        }
    }
    return [self sp_didMoveToSuperview];
}
- (void)sp_addSubview:(UIView *)view {
    [view setSuperBackgroundColor:self.backgroundColor];
    return [self sp_addSubview:view];
}

#pragma mark - Function Methods
- (void)setSuperBackgroundColorToSubviews:(UIColor *)color {
    for (UIView *subview in self.subviews) {
        [subview setSuperBackgroundColor:color];
    }
}

#pragma mark - Setters & Getters
#pragma mark sameBackgroundColorWithSuperview
- (BOOL)sameBackgroundColorWithSuperview {
    return [objc_getAssociatedObject(self, @selector(sameBackgroundColorWithSuperview)) boolValue];
}

- (void)setSameBackgroundColorWithSuperview:(BOOL)sameBackgroundColorWithSuperview {
    objc_setAssociatedObject(self, @selector(sameBackgroundColorWithSuperview), @(sameBackgroundColorWithSuperview), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (sameBackgroundColorWithSuperview) {
        UIColor *origin = self.originalBackgroundColor;
        [self setBackgroundColor:self.superBackgroundColor];
        self.originalBackgroundColor = origin;

    }else{
        [self setBackgroundColor:self.originalBackgroundColor];
    }
}


#pragma mark superBackgroundColor
- (void)setSuperBackgroundColor:(UIColor *)color {
    if (self.sameBackgroundColorWithSuperview) {
        UIColor *origin = self.originalBackgroundColor;
        [self setBackgroundColor:color];
        self.originalBackgroundColor = origin;

        [self setSuperBackgroundColorToSubviews:color];
    }
}

- (UIColor *)superBackgroundColor {
    UIColor *color = nil;
    if (self.sameBackgroundColorWithSuperview) {
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

- (UIColor *)originalBackgroundColor {
    return objc_getAssociatedObject(self, @selector(originalBackgroundColor));
}

- (void)setOriginalBackgroundColor:(UIColor * _Nonnull)originalBackgroundColor {
    objc_setAssociatedObject(self, @selector(originalBackgroundColor), originalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark darkModeBackgroundColor
- (UIColor *)darkModeBackgroundColor {
    return objc_getAssociatedObject(self, @selector(darkModeBackgroundColor));
}

- (void)setDarkModeBackgroundColor:(UIColor *)darkModeBackgroundColor {
    objc_setAssociatedObject(self, @selector(darkModeBackgroundColor), darkModeBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

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

//
//- (void)sp_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
////    self.layer.color
//    return [self sp_traitCollectionDidChange:previousTraitCollection];
//}

@end
