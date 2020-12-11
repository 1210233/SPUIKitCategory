//
//  UIViewController+XIBCreation.m
//  SmartCity
//
//  Created by ZCGC on 2017/5/12.
//  Copyright © 2017年 NRH. All rights reserved.
//

#import "UIViewController+XIBCreation.h"
#import <objc/runtime.h>

@implementation UIViewController (XIBCreation)

+ (instancetype)loadFromNib {
    NSString *nibName = NSStringFromClass([self class]);
    NSString *path = [[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"];
    if (!path) {
        return [[self alloc] init];
    }
    return [[self alloc] initWithNibName:nibName bundle:nil];
}

@end


@interface UIViewController (PresentationModal)
@end
@implementation UIViewController (PresentationModal)

+ (void)load {
    SEL originalSelector = @selector(init);
    SEL swizzledSelector = @selector(hook_init);
    
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

- (instancetype)hook_init {
    id instance = [self hook_init];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.modalPresentationCapturesStatusBarAppearance = YES;
    return instance;
}

@end

@interface UINavigationController (PresentationModal)
@end

@implementation UINavigationController (PresentationModal)

+ (void)load {
    SEL originalSelector = @selector(initWithRootViewController:);
    SEL swizzledSelector = @selector(hook_initWithRootViewController:);
    
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

- (instancetype)hook_initWithRootViewController:(UIViewController *)rootViewController {
    id instance = [self hook_initWithRootViewController:rootViewController];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.modalPresentationCapturesStatusBarAppearance = YES;
    return instance;
}

@end

@interface UIStoryboard (PresentationModal)
@end
@implementation UIStoryboard (PresentationModal)
+ (void)load {
    SEL originalSelector = @selector(instantiateInitialViewController);
    SEL swizzledSelector = @selector(hook_instantiateInitialViewController);
    
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

- (UIViewController *)hook_instantiateInitialViewController {
    UIViewController * vc = [self hook_instantiateInitialViewController];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    vc.modalPresentationCapturesStatusBarAppearance = YES;
    return vc;
}
@end
