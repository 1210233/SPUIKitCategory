//
//  UIColor+SPCreate.swift
//  WenYanWen
//
//  Created by Bee on 2020/12/18.
//

import UIKit


extension String {
    /// string[NSRage(location: loc, length: len)]
    public
    subscript(bounds: NSRange) -> String {
        if bounds.location < 0  || bounds.location >= self.count {
            return ""
        }
        var length = bounds.length
        if bounds.location + length > self.count {
            length = self.count - bounds.location
        }
        let sIndex = self.index(self.startIndex, offsetBy: bounds.location)
        let eIndex = self.index(sIndex, offsetBy: length)
        return String(self[sIndex..<eIndex])
    }
    /// string[x ..< y]
    public
    subscript(r: Range<Int>) -> String {
        if r.lowerBound < 0 ||
            r.lowerBound >= self.count ||
            r.lowerBound < r.upperBound {
            return ""
        }
        var e = r.upperBound
        if e < r.lowerBound {
            e = r.lowerBound
        }else if r.lowerBound + e > self.count {
            e = self.count - r.lowerBound
        }
        let sIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let eIndex = self.index(self.startIndex, offsetBy: e)
        return String(self[sIndex..<eIndex])
    }
    /// string[x ... y]
    public
    subscript(r: ClosedRange<Int>) -> String {
        if r.lowerBound < 0 ||
            r.lowerBound >= self.count ||
            r.lowerBound < r.upperBound {
            return ""
        }
        var e = r.upperBound
        if e < r.lowerBound {
            e = r.lowerBound
        }else if r.lowerBound + e >= self.count {
            e = self.count - r.lowerBound - 1
        }
        let sIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let eIndex = self.index(self.startIndex, offsetBy: e)
        return String(self[sIndex...eIndex])
    }
    /// string[x ...]
    public
    subscript(r: PartialRangeFrom<Int>) -> String {
        return self[r.lowerBound...self.count - 1]
    }
    /// string[...y]
    public
    subscript(r: PartialRangeThrough<Int>) -> String {
        if self.isEmpty {
            return ""
        }
        return self[0...r.upperBound]
    }
    /// string[..< y]
    public
    subscript(r: PartialRangeUpTo<Int>) -> String {
        if self.isEmpty {
            return ""
        }
        return self[0..<r.upperBound]
    }
    /// string[loc, len]
    public
    subscript(loc: Int, len: Int = 1) -> String {
        return self[NSRange(location: loc, length: len)]
    }
}


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
