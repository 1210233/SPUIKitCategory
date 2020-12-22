//
//  UIFont+AutoScale.swift
//  WenYanWen
//
//  Created by LSP on 2020/12/22.
//

import UIKit

extension UIFont {
    var autoscaled: Bool {
        get {
            if let n = objc_getAssociatedObject(self, "autoscaled") as? NSNumber {
                return n.boolValue
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, "autoscaled", NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
