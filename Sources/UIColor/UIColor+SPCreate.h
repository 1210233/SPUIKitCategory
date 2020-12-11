//
//  UIColor+SPCreate.h
//  SPUIKitCategory
//
//  Created by LSP on 15/10/23.
//  Copyright © 2015年 LSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SPCreate)

/**
 * @param hexColor RGBA mode: 0xRRGGBBAA.  RGB mode: 0xRRGGBB.
 * tint: if Red is zero, don't use RGBA mode, or make Red is 1.
*/
+ (UIColor *)colorWithHex:(NSUInteger)hexColor;


/// r.g.b.a RRRGGGBBB eg:23056098 -> r=23 g=56 b=98
+ (UIColor *)colorWithRGB:(NSUInteger)rgb;
/// alpha between 0~1.
+ (UIColor *)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha;

/**
 * @param color can be 0xAABBCC or 0XAABBCC, and or #AABBCC
 */
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
