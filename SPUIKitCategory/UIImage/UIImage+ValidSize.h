//
//  UIImage+ValidSize.h
//  HeartHeart
//
//  Created by LSP on 15/7/7.
//  Copyright (c) 2015年 LSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ValidSize)

- (NSData *)dataIn32KB;
- (NSData *)dataIn400KB;
- (NSData *)dataInKB:(NSUInteger)KB;
- (NSData *)dataInMB:(NSUInteger)MB;
- (NSData *)dataInBytes:(NSUInteger)bytes;


- (CGSize)validSize;

- (UIImage *)scaledToSize:(CGSize)newSize;
@end
