//
//  UIView+XIBCreation.h
//  SmartCity
//
//  Created by LSP on 2017/5/12.
//  Copyright © 2017年 LSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XIBCreation)

/**
 *  从XIB文件（与类名相同的xib）初始化。
 */
+ (instancetype)loadFromNib;

@end
