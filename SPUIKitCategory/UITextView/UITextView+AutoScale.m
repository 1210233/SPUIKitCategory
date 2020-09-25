//
//  UITextView+AutoScale.m
//  SPUIKitCategory_Example
//
//  Created by LSP on 2020/9/25.
//  Copyright © 2020 1210233. All rights reserved.
//

#import "UITextView+AutoScale.h"
#import "UIFont+SPAutoScale.h"
#import <objc/runtime.h>

@implementation UITextView (AutoScale)

+ (void)load{
    NSArray *originalSelectors = @[@"setFont:"];
    
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

- (void)sp_setFont:(UIFont *)font {
    
    if (self.autoScaleFont) {
        if (!font.autoscaled) {
            font = [font fontWithSize:font.pointSize * screenWidthScaleBase375()];
        }
    }else{
        if (font.autoscaled) {
            font = [font fontWithSize:font.pointSize / screenWidthScaleBase375()];
        }
    }
    return [self sp_setFont:font];
}

- (void)setAutoScaleFont:(BOOL)autoScaleFont {
    if (autoScaleFont == self.autoScaleFont)
        return;
    
    objc_setAssociatedObject(self, "autoScaleFont", @(autoScaleFont), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (autoScaleFont) {
        UIFont *font = [self.font fontWithSize:self.font.pointSize * screenWidthScaleBase375()];
        font.autoscaled = YES;
        return [self sp_setFont:font];
    }else{
        UIFont *font = [self.font fontWithSize:self.font.pointSize / screenWidthScaleBase375()];
        font.autoscaled = NO;
        return [self sp_setFont:font];
    }
}

- (BOOL)autoScaleFont {
    return [objc_getAssociatedObject(self, "autoScaleFont") boolValue];
}

@end
