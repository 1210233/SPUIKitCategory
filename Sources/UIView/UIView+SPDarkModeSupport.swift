//
//  UIView+SPDarkModeSupport.swift
//  SwiftPackageTest
//
//  Created by LSP on 2020/12/16.
//  Copyright © 2020 LSP. All rights reserved.
//

import UIKit

extension UIView: PRExchangeMethod {
    public static func exchangeMethodNames() -> [String]? {
        return ["setBackgroundColor:",
                "addSubview:",
                "didMoveToSuperview"]
        
    }
    
    public static func exchangeMethodPrefix() -> String? {
        return nil
    }
    
//    @available(iOS 12.0, *)
    var darkModeBackgroundColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, "darkModeBackgroundColor") as? UIColor
        }
        set {
            objc_setAssociatedObject(self, "darkModeBackgroundColor", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            
            if let value = newValue {
                let normal = (self.backgroundColor ?? UIView.appearance().backgroundColor) ?? UIColor.white
                
                var color = normal
                if #available(iOS 13.0, *) {
                    color = UIColor(dynamicProvider: { (traitCollection: UITraitCollection) -> UIColor in
                        if traitCollection.userInterfaceStyle == .dark {
                            return value
                        }
                        return color.resolvedColor(with: traitCollection)
                    })
                } else if #available(iOS 12.0, *) {
                    if let window = UIApplication.shared.keyWindow, window.traitCollection.userInterfaceStyle == .dark {
                        color = value
                    }
                }
            }
        }
    }
}
