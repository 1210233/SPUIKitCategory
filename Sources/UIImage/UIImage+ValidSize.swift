//
//  UIImage+ValidSize.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/18.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIImage {
    
    public
    var dataIn32KB: Data {
        get {
            if let d = objc_getAssociatedObject(self, &sp_dataIn32KBKey) as? Data {
                return d
            }
            let d = self.dataIn(KB: 32)
            objc_setAssociatedObject(self, &sp_dataIn32KBKey, d, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return d
        }
    }
    
    public
    var dataIn400KB: Data {
        get {
            if let d = objc_getAssociatedObject(self, &sp_dataIn400KBKey) as? Data {
                return d
            }
            let d = self.dataIn(KB: 400)
            objc_setAssociatedObject(self, &sp_dataIn400KBKey, d, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return d
        }
    }
    
    public
    func dataIn(KB: UInt) -> Data {
        return self.dataIn(bytes: KB * 1024)
    }
    
    public
    func dataIn(MB: UInt) -> Data {
        return self.dataIn(KB: MB * 1024)
    }
    
    public
    func dataIn(bytes: UInt) -> Data {
        var img = self
        var width = self.size.width
        var height = self.size.height
        
        var limit: CGFloat = 1600
        var quality: CGFloat = 1
        
        var data = Data()
        repeat {
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
                img = self.scaledTo(size: CGSize(width: width, height: height));
            }
            
            repeat {
                quality -= 0.05
                if let d = img.jpegData(compressionQuality: quality) {
                    data = d
                }else {
                    break
                }
            } while (data.count > bytes && quality > 0);
        } while (quality < 0 && limit > 0)
        
        if limit < 0 {
            return Data()
        } else {
            return data
        }
    }
    
    public
    var validSize: CGSize {
        get {
            if let num = objc_getAssociatedObject(self, &sp_validSizeKey) as? NSNumber {
                return num.cgSizeValue
            }else{
                var width  = self.size.width;
                var height = self.size.height;
                var size = self.size
                if (width > 1500 || height > 1500) {
                    if (width > height) {
                        height *= (1500 / width);
                        width = 1500;
                    }else{
                        width *= (1500 / height);
                        height = 1500;
                    }
                    size = CGSize(width: ceil(width), height: ceil(height));
                }
                objc_setAssociatedObject(self, &sp_validSizeKey, NSNumber(cgSize: size), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return size
            }
        }
    }
    
    public
    func scaledTo(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
#endif
