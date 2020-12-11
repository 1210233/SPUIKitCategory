//
//  UITextView+AutoScale.h
//  SPUIKitCategory_Example
//
//  Created by LSP on 2020/9/25.
//  Copyright © 2020 1210233. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SPFunctions.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (AutoScale)
/**
 根据375屏幕宽度的比例自动缩放字体大小.
 */
@property (nonatomic, assign) IBInspectable BOOL autoScaleFont;
@end

NS_ASSUME_NONNULL_END
