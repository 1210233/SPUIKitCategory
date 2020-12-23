//
//  UIWindow+KeyWindow.swift
//  WenYanWen
//
//  Created by LSP on 2020/12/22.
//

import UIKit

extension UIWindow {
    public
    class var window: UIWindow {
        get {
            if let v = UIApplication.shared.keyWindow {
                return v
            }
            if let v = UIApplication.shared.windows.first {
                return v
            }
            return UIWindow()
        }
    }
}
