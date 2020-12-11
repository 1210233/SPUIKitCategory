//
//  UIView+SPDarkModeSupport.h
//  SPUIKitCategory
//
//  Created by LSP on 2020/9/14.
//  Copyright © 2020 lsp. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SPDarkModeSupport)
@property (nonatomic, copy) IBInspectable UIColor *darkModeBackgroundColor API_AVAILABLE(ios(12.0));
@property (nonatomic, readonly, copy) UIColor *superBackgroundColor;
@property (nonatomic, readonly, copy) UIColor *originalBackgroundColor;
@property (nonatomic, assign) IBInspectable BOOL sameBackgroundColorWithSuperview;
@end

NS_ASSUME_NONNULL_END
