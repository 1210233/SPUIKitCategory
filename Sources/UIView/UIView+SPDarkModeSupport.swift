//
//  UIView+SPDarkModeSupport.swift
//  SwiftPackageTest
//
//  Created by LSP on 2020/12/16.
//  Copyright © 2020 LSP. All rights reserved.
//

import UIKit

@objc public
extension UIView: PRExchangeMethod {
    
    public
    static var exchangeMethodPrefix: String?
    
    /// 需要交换的方法名
    var darkModeSupportExchangeMethodNames: [String] {
        return ["setBackgroundColor:",
                "addSubview:",
                "didMoveToSuperview"]
    }
    
    /// 深色模式下的背景颜色
    @IBInspectable public
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
    
    /// 父视图的背景颜色
    public
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
    
    /// 深色模式之前的颜色
    public
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
    
    /// 保持背景颜色与父视图相同
    public
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
    
    func sp_setBackgroundColor(_ color: UIColor) {
        self.originalBackgroundColor = color
        var temp = color
        if #available(iOS 13.0, *) {
            if let night = self.darkModeBackgroundColor {
                temp = UIColor(dynamicProvider: { (collection) -> UIColor in
                    if collection.userInterfaceStyle == .dark {
                        return night
                    }
                    return color.resolvedColor(with: collection)
                })
            }
        } else if #available(iOS 12.0, *) {
            if let night = self.darkModeBackgroundColor, let window = UIApplication.shared.delegate?.window {
                if let w = window, w.traitCollection.userInterfaceStyle == .dark {
                    temp = night
                }
            }
        }
        
        self.setSuperBackgroundColorToSubviews(temp)
        return self.sp_setBackgroundColor(temp)
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
    
    func setSuperBackgroundColorToSubviews(_ color: UIColor) {
        for subview in self.subviews {
            subview.superBackgroundColor = color
        }
    }
}
