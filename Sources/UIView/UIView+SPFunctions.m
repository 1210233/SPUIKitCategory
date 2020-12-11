//
//  UIView+SPFunctions.m
//  SPUIKitCategory_Example
//
//  Created by LSP on 2020/9/25.
//  Copyright © 2020 1210233. All rights reserved.
//

#import "UIView+SPFunctions.h"

@implementation UIView (SPFunctions)
@end


CGFloat screenWidthScaleBase375() {
    static CGFloat scale = 1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
        if (UIInterfaceOrientationIsPortrait(o)) {
            scale = [UIScreen mainScreen].bounds.size.width / 375.;
        }else if (UIInterfaceOrientationIsLandscape(o)) {
            scale = [UIScreen mainScreen].bounds.size.height / 375.;
        }
    });
    
    return scale;
}
