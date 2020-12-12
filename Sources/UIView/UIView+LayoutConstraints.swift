//
//  File.swift
//  
//
//  Created by LSP on 2020/12/11.
//

import Foundation


extension UIView: PRExchangeMethod {
    
    var constraintsForOtherViews: NSMutableDictionary {
        get {
            if let dic = objc_getAssociatedObject(self, "constraintsForOtherViews") as? NSMutableDictionary {
                return dic
            } else {
                let dic = NSMutableDictionary()
                objc_setAssociatedObject(self, "constraintsForOtherViews", dic, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dic
            }
        }
    }
    
    var storedConstraintsKey: String {
        if let key = objc_getAssociatedObject(self, "storedConstraintsKey") as? String {
            return key
        } else {
            let key = String(format: "%p", self)
            objc_setAssociatedObject(self, "storedConstraintsKey", key, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            return key
        }
    }
    
    func constraintsDicFor(view: UIView) -> NSMutableDictionary {
        if let dic = self.constraintsForOtherViews[view.storedConstraintsKey] as? NSMutableDictionary {
            return dic
        } else {
            let dic = NSMutableDictionary()
            self.constraintsForOtherViews[view.storedConstraintsKey] = dic
            return dic
        }
    }
    
    /**
     本视图宽度的约束. 如果在XIB中已创建该约束，则会自动关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
     */
    @IBOutlet
    var widthConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "widthConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "widthConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var widthConstant: CGFloat {
        get {
            return self.widthConstraint?.constant ?? 0;
        }
        set {
            if let cons = objc_getAssociatedObject(self, "widthConstraint") as? NSLayoutConstraint {
                cons.constant = newValue;
            }else{
                self.makeWidthConstraint(newValue)
            }
        }
    }
    
    @discardableResult
    func makeWidthConstraint(_ width: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        
        self.addConstraint(constraint)
        self.widthConstraint = constraint
        return constraint;
    }
    
    
    
    
    
    func exchange() {
//        let originalSelectors = ["addConstraint:", "removeConstraint:"]
//
//
//        for selectorName in originalSelectors {
//
//            let originalSelector = NSSelectorFromString(selectorName);
//            let swizzledSelector = NSSelectorFromString("sp_" + selectorName)
//
//            if let originalMethod = class_getInstanceMethod(self.classForCoder, originalSelector), let swizzledMethod = class_getInstanceMethod(self.classForCoder, swizzledSelector) {
//
//                var didAddMethod =
//                    class_addMethod(self.classForCoder,
//                                    originalSelector,
//                                    method_getImplementation(swizzledMethod),
//                                    method_getTypeEncoding(swizzledMethod));
//
//                if (didAddMethod) {
//                    class_replaceMethod(self.classForCoder,
//                                        swizzledSelector,
//                                        method_getImplementation(originalMethod),
//                                        method_getTypeEncoding(originalMethod));
//
//                } else {
//                    method_exchangeImplementations(originalMethod, swizzledMethod);
//                }
//
//                if let layoutClass = NSClassFromString("_UILayoutGuide") { // _UILayoutGuide 这个类需要使用原始的方法。所以再交换一次。
//                    didAddMethod =
//                        class_addMethod(layoutClass,
//                                        originalSelector,
//                                        method_getImplementation(swizzledMethod),
//                                        method_getTypeEncoding(swizzledMethod));
//
//                    if (didAddMethod) {
//                        class_replaceMethod(layoutClass,
//                                            swizzledSelector,
//                                            method_getImplementation(originalMethod),
//                                            method_getTypeEncoding(originalMethod));
//
//                    } else {
//                        method_exchangeImplementations(originalMethod, swizzledMethod);
//                    }
//                }
//            }
//        }
    }
    
//    func sp_addConstraint(_ constraint: NSLayoutConstraint) {
//
//    }
}

