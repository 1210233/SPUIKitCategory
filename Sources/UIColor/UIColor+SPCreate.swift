//
//  UIColor+SPCreate.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/18.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit
import SPFoundationCategory

extension UIColor {
    
    /// 16进制数值初始化颜色
    /// - Parameter hex: 若长度4字节，第一字节为Alpha，二三四字节为RGB。
    ///                  若长度3自己，则三个字节分别为RGB，Alpha为1。
    convenience public
    init(hex: UInt) {
        
        let c1 = UInt8(hex >> 24 & 0xFF)
        let c2 = UInt8(hex >> 16 & 0xFF)
        let c3 = UInt8(hex >> 8 & 0xFF)
        let c4 = UInt8(hex & 0xFF)
        
        if c1 != 0 {
            self.init(red: CGFloat(c1) / 255, green: CGFloat(c2) / 255, blue: CGFloat(c3) / 255, alpha: CGFloat(c4 - 1) / 254)
        }else{
            self.init(red: CGFloat(c2) / 255, green: CGFloat(c3) / 255, blue: CGFloat(c4) / 255, alpha: 1)
        }
    }
    
    /// r.g.b.a RRRGGGBBB eg:23056098 -> r=23 g=56 b=98
    convenience public
    init(RGB rgb: UInt, alpha: CGFloat = 1) {
        let red = CGFloat((rgb / 1000 / 1000) % 1000);
        let green = CGFloat((rgb / 1000) % 1000);
        let blue = CGFloat(rgb % 1000);
        self.init(red: CGFloat(red) / 999, green: CGFloat(green) / 999, blue: CGFloat(blue) / 999, alpha: alpha)
    }
    
    /**
     * @param color can be 0xAABBCC or 0XAABBCC, and or #AABBCC
     */
    convenience public
    init(hexString string: String, alpha: CGFloat = 1) {
        var cString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        guard cString.count >= 6 else {
            self.init(white: 0, alpha:0)
            return
        }
        
        if let index = cString.firstIndex(of: Character("0X")) {
            cString = String(cString[index...])
        }
        if let index = cString.firstIndex(of: Character("0x")) {
            cString = String(cString[index...])
        }
        if let index = cString.firstIndex(of: Character("#")) {
            cString = String(cString[index...])
        }
        guard cString.count == 6 else {
            self.init(white: 0, alpha:0)
            return
        }
        
        var r: UInt32 = 0
        var g: UInt32 = 0
        var b: UInt32 = 0
        Scanner(string: cString[0, 2]).scanHexInt32(&r)
        Scanner(string: cString[2, 2]).scanHexInt32(&g)
        Scanner(string: cString[4, 2]).scanHexInt32(&b)
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
}
#endif
