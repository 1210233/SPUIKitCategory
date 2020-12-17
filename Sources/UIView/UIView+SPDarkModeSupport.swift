//
//  UIView+SPDarkModeSupport.swift
//  SwiftPackageTest
//
//  Created by LSP on 2020/12/16.
//  Copyright © 2020 LSP. All rights reserved.
//

import UIKit

@objc // 必需在拓展前或属性前加上@objc，否则class_copyPropertyList方法读取不到下面的属性
extension UIView: PRExchangeMethod {
    var darkModeSupportExchangeMethodNames: [String] {
        return ["setBackgroundColor:",
                "addSubview:",
                "didMoveToSuperview"]
        
    }
    
    public static func exchangeMethodPrefix() -> String? {
        return nil
    }
    
    public func sp_setBackgroundColor(_ color: UIColor) {
        return self.sp_setBackgroundColor(color)
    }
    
    func sp_addSubview(_ view: UIView) {
        if let color = self.backgroundColor {
            view.superBackgroundColor = color
        }
        return self.sp_addSubview(view)
    }
    
    func sp_didMoveToSuperview() {
        if self.superview != nil {
            if self.sameBackgroundColorWithSuperview {
                let color = self.superBackgroundColor
                self.superBackgroundColor = color
            }
        }
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
    
    func setSuperBackgroundColorToSubviews(_ color: UIColor) {
        for subview in self.subviews {
            subview.superBackgroundColor = color
        }
    }
    
//    @property (nonatomic, copy) IBInspectable UIColor *darkModeBackgroundColor API_AVAILABLE(ios(12.0));
    var superBackgroundColor: UIColor {
        get {
            var color: UIColor?
            if self.sameBackgroundColorWithSuperview {
                color = self.superview?.superBackgroundColor
            }
            if color == nil {
                color = self.backgroundColor
            }
            if color == nil {
                if #available(iOS 13.0, *) {
                    color = UIColor.systemBackground
                } else {
                    color = UIColor.white
                }
                color = self.backgroundColor
            }
            return color!
        }
        set {
            if self.sameBackgroundColorWithSuperview {
                let origin = self.originalBackgroundColor
                self.backgroundColor = newValue
                self.originalBackgroundColor = origin
                
                self.setSuperBackgroundColorToSubviews(newValue)
            }
        }
    }
    var originalBackgroundColor: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, "originalBackgroundColor") as? UIColor {
                return color
            }
            return self.backgroundColor
        }
        set {
            objc_setAssociatedObject(self, "originalBackgroundColor", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var sameBackgroundColorWithSuperview: Bool {
        get {
            if let value = objc_getAssociatedObject(self, "sameBackgroundColorWithSuperview") as? NSNumber {
                return value.boolValue
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, "sameBackgroundColorWithSuperview", NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if newValue {
                let origin = self.originalBackgroundColor
                self.backgroundColor = self.superBackgroundColor
                self.originalBackgroundColor = origin
            }else {
                self.backgroundColor = self.originalBackgroundColor
            }
        }
    }
}
