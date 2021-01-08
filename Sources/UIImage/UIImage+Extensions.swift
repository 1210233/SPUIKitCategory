//
//  UIImage+Extensions.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/6.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIImage {
    
    public class
    func from(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        guard (size.width > 0 && size.height > 0) else {
            return UIImage()
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        ctx.setFillColor(color.cgColor)
        ctx.fill(CGRect(origin: CGPoint.zero, size: size))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img ?? UIImage()
    }
    
    public class
    func from(layer: CALayer) -> UIImage {
        if let ctx = UIGraphicsGetCurrentContext() {
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0)
            layer.render(in: ctx)
            
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return img ?? UIImage()
        }
        return UIImage()
    }
}
#endif
