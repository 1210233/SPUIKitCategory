//
//  UIView+Snapshot.h
//  SPUIKitCategory
//
//  Created by LSP on 15/12/10.
//  Copyright © 2015年 LSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Snapshot)
- (UIImage *)snapImage;
@end

@interface CALayer (Snapshot)
- (UIImage *)snapImage;
@end


