//
//  UIView+Nib.h
//  SPKit
//
//  Created by 李双鹏 on 15/10/04.
//  Copyright (c) 2015 LSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SPNib)

/**
 *  加载nib
 */
+ (UINib *)loadNib;

/**
 *  加载nib
 *
 *  @param nibName nib名字
 */
+ (UINib *)loadNibNamed:(NSString*)nibName;

/**
 *  加载nib
 *
 *  @param nibName nib名字
 *  @param bundle  nib文件包（目录）
 */
+ (UINib *)loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

#pragma mark --------- XIB INSPECTABLE -----------
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;
@property (nonatomic, assign) IBInspectable UIColor *shadowColor;
@property (nonatomic, assign) IBInspectable CGSize  shadowOffset;
@property (nonatomic, assign) IBInspectable BOOL    maskToBounds;

@end
