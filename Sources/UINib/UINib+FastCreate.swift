//
//  UINib+FastCreate.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/18.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

/**
 *  从Main Bundle中加载NIB。
 *
 *  @param nibName XIB的文件名
 *  @return 对应的NIB对象
 */
extension UINib {
    convenience public
    init(nibName: String) {
        self.init(nibName: nibName, bundle: nil)
    }
}

extension UIView {
    public
    class func nibInMainBundle(nibName: String = "") -> UINib {
        if nibName.isEmpty {
            return UINib(nibName: String(describing: self))
        }
        return UINib(nibName: nibName)
    }
}

extension UIViewController {
    public
    class func nibInMainBundle(nibName: String = "") -> UINib {
        if nibName.isEmpty {
            return UINib(nibName: String(describing: self))
        }
        return UINib(nibName: nibName)
    }
}

extension String {
    
    public
    func nibInMainBundle() -> UINib? {
        if self.isEmpty {
            return nil
        }
        return Bundle.main.loadNibNamed(self, owner: nil, options: nil)?.first as? UINib
    }
    
    public
    func nibInBundle(_ bundleName: String) -> UINib? {
        if self.isEmpty {
            return nil
        }
        return Bundle(identifier: bundleName)?.loadNibNamed(self, owner: nil, options: nil)?.first as? UINib
    }
}
#endif
