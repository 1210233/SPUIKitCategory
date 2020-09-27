//
//  UIImage+ValidSize.m
//  HeartHeart
//
//  Created by LSP on 15/7/7.
//  Copyright (c) 2015年 LSP. All rights reserved.
//

#import "UIImage+ValidSize.h"

@implementation UIImage (ValidSize)

- (NSData *)dataIn400KB {
    return [self dataInFileSize:400 * 1024];
}

- (NSData *)dataInFileSize:(NSUInteger)bytes {
    UIImage *img = self;
    int width  = self.size.width;
    int height = self.size.height;
    CGFloat limit = 1600.;
    CGFloat quality;
    
    // 压缩至小于400KB
    NSData *data;
    do{
        quality = 1.05;
        limit -= 100;
        if (width > limit || height > limit) {
            if (width > height) {
                height *= (limit / width);
                width = limit;
            }else{
                width *= (limit / height);
                height = limit;
            }
//            int h = (self.size.width - width) / 2;
//            int v = (self.size.height - height) / 2;
//            img = [self resizableImageWithCapInsets:UIEdgeInsetsMake(v , h, v, h) ];
            img = [self scaledToSize:CGSizeMake(width, height)];
        }
        
        do {
            @autoreleasepool{
                data = UIImageJPEGRepresentation(img, (quality -= .05));
            }
        } while (data.length > bytes && quality > 0);
        
    }while (quality < 0 && limit > 0);
    
    if (limit < 0) {
        return [NSData data];
    }else
        return data;
}

- (CGSize)validSize {
    CGFloat width  = self.size.width;
    CGFloat height = self.size.height;
    if (width > 1500 || height > 1500) {
        if (width > height) {
            height *= (1500 / width);
            width = 1500;
        }else{
            width *= (1500 / height);
            height = 1500;
        }
        return CGSizeMake(ceil(width), ceil(height));
    }else{
        return self.size;
    }
}

- (UIImage*)scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
