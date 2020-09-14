//
//  UIView+SuperViewBackgroundColor.h
//  SPKitCategory
//
//  Created by LSP on 2020/9/14.
//  Copyright © 2020 lsp. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SuperViewBackgroundColor)
@property (nonatomic, assign) IBInspectable BOOL sameBackgroundColorWithSuperview;
@end

NS_ASSUME_NONNULL_END
