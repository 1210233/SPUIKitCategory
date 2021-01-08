//
//  UIView+Snapshot.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/15.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension CALayer {
    public
    func snapImage(opaque: Bool = false) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, opaque, 0.0)
        if let ctx = UIGraphicsGetCurrentContext() {
            self.render(in: ctx)
            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return img
            }
        }
        UIGraphicsEndImageContext()
        return UIImage()
    }
}

extension UIView {
    public
    func snapImage(opaque: Bool = false) -> UIImage {
        return self.layer.snapImage(opaque: opaque)
    }
}
#endif
