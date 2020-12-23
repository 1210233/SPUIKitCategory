//
//  UIFont+FastCreate.swift
//  WenYanWen
//
//  Created by LSP on 2020/12/22.
//

import UIKit

extension UIFont {
    
    public
    class func regularPingFang(ofSize size: CGFloat) -> UIFont {
        if let f = UIFont(name: "PingFangSC-Regular", size: size) {
            return f
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    public
    class func mediumPingFang(ofSize size: CGFloat) -> UIFont {
        if let f = UIFont(name: "PingFangSC-Medium", size: size) {
            return f
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    public
    class func boldPingFang(ofSize size: CGFloat) -> UIFont {
        if let f = UIFont(name: "PingFangSC-Semibold", size: size) {
            return f
        }
        return UIFont.boldSystemFont(ofSize: size)
    }
}
