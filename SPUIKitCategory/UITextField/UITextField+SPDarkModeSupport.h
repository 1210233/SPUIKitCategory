//
//  UITextField+SPDarkModeSupport.h
//  SPUIKitCategory
//
//  Created by LSP on 2020/9/16.
//  Copyright © 2020 SP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (SPDarkModeSupport)
@property (nonatomic, copy) IBInspectable UIColor *darkModeTextColor API_AVAILABLE(ios(12.0));
@end

NS_ASSUME_NONNULL_END
