//
//  UIColor+SPCreate.m
//  SPUIKitCategory
//
//  Created by LSP on 15/10/23.
//  Copyright © 2015年 LSP. All rights reserved.
//

#import "UIColor+SPCreate.h"

@implementation UIColor (SPCreate)

+ (UIColor *)colorWithHex:(NSUInteger)hexColor {
    // get components.
    unsigned char c1 = ((hexColor >> 24) & 0xFF);
    unsigned char c2 = ((hexColor >> 16) & 0xFF);
    unsigned char c3 = ((hexColor >> 8) & 0xFF);
    unsigned char c4 = (hexColor & 0xFF);
    if (c1 != 0) {
        return [UIColor colorWithRed:(c1 / 255.) green:(c2 / 255.) blue:(c3 / 255.) alpha:(c4 / 255.)];
    }else {
        return [UIColor colorWithRed:(c2 / 255.) green:(c3 / 255.) blue:(c4 / 255.) alpha:1];
    }
}


+ (UIColor *)colorWithRGB:(NSUInteger)rgb {
    return [self colorWithRGB:rgb alpha:1];
}

+ (UIColor *)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha {
    CGFloat red = ((rgb / 1000 / 1000) % 1000);
    CGFloat green = ((rgb / 1000) % 1000);
    CGFloat blue = (rgb % 1000);
    return [UIColor colorWithRed:red/999. green:green/999. blue:blue/999. alpha:alpha];
}


+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"] ||
        [cString hasPrefix:@"0x"])
    {
        cString = [cString substringFromIndex:2];
    
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    } else if ([cString hasPrefix:@"#"]) {
        
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range = NSMakeRange(0, 2);
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:alpha];
}


@end
