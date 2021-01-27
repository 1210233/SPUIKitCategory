//
//  UIView+XIBCreation.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/15.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

extension UIView {
    
    /// 从XIB文件（与类名相同的xib）初始化。
    /// - Parameters:
    ///   - nibName: 默认与类名相同
    ///   - owner: owner
    ///   - bundle: mainBundle
    /// - Returns: 实例
    public class
    func loadFromNib(_ nibName: String = "", owner: Any? = nil, bundle: Bundle = Bundle.main) -> Self? {
        let name = nibName.isEmpty ? String(describing: self) : nibName
        if let arr = bundle.loadNibNamed(name, owner: owner, options: nil) {
            for obj in arr {
                if let cls = obj as? NSObject, cls is Self  {
                    return cls as? Self
                }
            }
        }
        return nil
    }
}
#endif
