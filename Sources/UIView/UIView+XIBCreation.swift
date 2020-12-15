//
//  UIView+XIBCreation.swift
//  SwiftPackageTest
//
//  Created by LSP on 2020/12/15.
//  Copyright © 2020 LSP. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 从XIB文件（与类名相同的xib）初始化。
    /// - Parameters:
    ///   - nibName: 默认与类名相同
    ///   - owner: owner
    ///   - bundle: mainBundle
    /// - Returns: 实例
    public class
    func loadFromNib(withName nibName: String = String(describing: self), owner: Any? = nil, bundle: Bundle = Bundle.main) -> UIView? {
        if let arr = bundle.loadNibNamed(nibName, owner: owner, options: nil) {
            for obj in arr {
                if let cls = obj as? NSObject, cls.isKind(of: self.classForCoder())  {
                    return (cls as! UIView)
                }
            }
        }
        return nil
    }
}

