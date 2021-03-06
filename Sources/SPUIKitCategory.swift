//
//  SPUIKitCategory.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/12.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)

import UIKit

public let screenWidthScaleBase375: CGFloat = {
    var scale: CGFloat = 1
    let o = UIApplication.shared.statusBarOrientation
    
    if (o.isPortrait) {
        scale = UIScreen.main.bounds.size.width / 375
    }else if (o.isLandscape) {
        scale = UIScreen.main.bounds.size.height / 375
    }
    return scale
}()


extension BinaryInteger {
    @inlinable public var scaleBase375: CGFloat {
        return CGFloat(self) * screenWidthScaleBase375
    }
}
extension BinaryFloatingPoint {
    @inlinable public var scaleBase375: CGFloat {
        return CGFloat(self) * screenWidthScaleBase375
    }
}

extension CGSize {
    @inlinable public var scaleBase375: Self {
        return Self(width: self.width.scaleBase375,
                    height: self.height.scaleBase375)
    }
}
extension CGPoint {
    @inlinable public var scaleBase375: Self {
        return Self(x: self.x.scaleBase375,
                    y: self.y.scaleBase375)
    }
}
extension CGRect {
    @inlinable public var scaleBase375: Self {
        return Self(x: self.origin.x.scaleBase375,
                    y: self.origin.y.scaleBase375,
                    width: self.size.width.scaleBase375,
                    height: self.size.height.scaleBase375)
    }
}
extension UIEdgeInsets {
    @inlinable public var scaleBase375: Self {
        return Self(top: self.top.scaleBase375,
                    left: self.left.scaleBase375,
                    bottom: self.bottom.scaleBase375,
                    right: self.right.scaleBase375)
    }
}


// Runtime Associated Keies
var sp_darkModeTextColorKey                   = "sp_darkModeTextColorKey"
var sp_darkModeBackgroundColorKey             = "sp_darkModeBackgroundColorKey"
var sp_touchHighlightAbleKey                  = "sp_touchHighlightAbleKey"
var sp_highlightedBackgroundColorKey          = "sp_highlightedBackgroundColorKey"
var sp_unHighlightedBackgroundColorKey        = "sp_unHighlightedBackgroundColorKey"
var sp_autoscaledKey                          = "sp_autoscaledKey"
var sp_autoScaleFontKey                       = "sp_autoScaleFontKey"
var sp_dataIn32KBKey                          = "sp_dataIn32KBKey"
var sp_dataIn400KBKey                         = "sp_dataIn400KBKey"
var sp_constraintsForOtherViewsKey            = "sp_constraintsForOtherViewsKey"
var sp_storedConstraintsKey                   = "sp_storedConstraintsKey"
var sp_widthConstraintKey                     = "sp_widthConstraintKey"
var sp_heightConstraintKey                    = "sp_heightConstraintKey"
var sp_topConstraintKey                       = "sp_topConstraintKey"
var sp_leftConstraintKey                      = "sp_leftConstraintKey"
var sp_rightConstraintKey                     = "sp_rightConstraintKey"
var sp_bottomConstraintKey                    = "sp_bottomConstraintKey"
var sp_centerXConstraintKey                   = "sp_centerXConstraintKey"
var sp_centerYConstraintKey                   = "sp_centerYConstraintKey"
var sp_originalBackgroundColorKey             = "sp_originalBackgroundColorKey"
var sp_sameBackgroundColorWithSuperviewKey    = "sp_sameBackgroundColorWithSuperviewKey"
var sp_validSizeKey                           = "sp_validSizeKey"


// 放在AppDelegate中
#if NEVER_COMPILE

extension AppDelegate {
    
    func exchangeMethodFor(class cls: AnyClass) {
        let prefix = "sp_"
        var cnt = UInt32()
        var names = [String]()
        if let c = cls as? NSObject.Type, let pts = class_copyPropertyList(cls, &cnt) {
            for i in 0 ..< Int(cnt) {
                let name = String(cString:property_getName(pts[i]))
                guard name.hasSuffix("ExchangeMethodNames") else {
                    continue
                }
                
                if let arr = c.init().perform(Selector(name)) {
                    
                    if let array = arr.takeUnretainedValue() as? [String] {
                        names += array
                    }
                }
            }
        }
        
        #if DEBUG // 打印类名
        if !names.isEmpty {
            print("----------\(cls)----------")
        }
        #endif

        for name in names {
            print("[\(cls) "  + name + "] to [\(cls) " + prefix + name + "]")
            
            let originalSelector = Selector(name);
            let swizzledSelector = Selector(prefix + name)
            
            guard let originalMethod = class_getInstanceMethod(cls, originalSelector) else {
                #if DEBUG
                print("Method(" + name + ") not found for \(cls)")
                #endif
                continue
            }
            
            guard let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector) else {
                #if DEBUG
                print("Method(" + prefix + name + ") not found for \(class_getName(cls))")
                #endif
                continue
            }
            
            let didAddMethod =
                class_addMethod(cls,
                                originalSelector,
                                method_getImplementation(swizzledMethod),
                                method_getTypeEncoding(swizzledMethod));
            
            if (didAddMethod) {
                class_replaceMethod(cls,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod));
                
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    }

    @_dynamicReplacement(for:application(_:didFinishLaunchingWithOptions:))
    func sp_application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
            print("=============================================\n开始方法交换...")
        #endif
        
        let typeCount = Int(objc_getClassList(nil, 0))
        let  types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleaseintTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleaseintTypes, Int32(typeCount)) //获取所有的类
        
        var otherClasses = ["UIView", "UIViewController", "UIStoryboard"]
        
        for index in 0 ..< typeCount {
            let cls: AnyClass = types[index]
            
            if class_conformsToProtocol(cls, NSObjectProtocol.self) {
                let name = String(describing: cls)
                if otherClasses.contains(name) {
                    otherClasses -= name
                }
                self.exchangeMethodFor(class: cls)
            }
        }
        
        for name in otherClasses {
            if let cls = objc_getClass(name) as? AnyClass {
                self.exchangeMethodFor(class: cls)
            }
        }
        
        types.deallocate()
        #if DEBUG // 打印类名
            print("结束方法交换。\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<=====================")
        #endif
        return self.application(application, didFinishLaunchingWithOptions:launchOptions)
    }
}

#endif


#endif
