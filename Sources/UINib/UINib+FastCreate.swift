//
//  UINib+FastCreate.swift
//  WenYanWen
//
//  Created by Bee on 2020/12/18.
//

import UIKit

/**
 *  从Main Bundle中加载NIB。
 *
 *  @param nibName XIB的文件名
 *  @return 对应的NIB对象
 */
extension UINib {
    convenience
    init(nibName: String) {
        self.init(nibName: nibName, bundle: nil)
    }
}

extension UIView {
    class func nibInMainBundle(nibName: String = "") -> UINib {
        if nibName.isEmpty {
            return UINib(nibName: String(describing: self))
        }
        return UINib(nibName: nibName)
    }
}

extension UIViewController {
    class func nibInMainBundle(nibName: String = "") -> UINib {
        if nibName.isEmpty {
            return UINib(nibName: String(describing: self))
        }
        return UINib(nibName: nibName)
    }
}

extension String {
    func nibInMainBundle() -> UINib? {
        if self.isEmpty {
            return nil
        }
        return Bundle.main.loadNibNamed(self, owner: nil, options: nil)?.first as? UINib
    }
    
    func nibInBundle(_ bundleName: String) -> UINib? {
        if self.isEmpty {
            return nil
        }
        return Bundle(identifier: bundleName)?.loadNibNamed(self, owner: nil, options: nil)?.first as? UINib
    }
}
