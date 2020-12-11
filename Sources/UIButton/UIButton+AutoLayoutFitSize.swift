//
//  File.swift
//  
//
//  Created by Bee on 2020/12/11.
//

import UIKit


extension UIButton {
    public
    func fitWidth() -> CGFloat {
        return self.fitWidth(offset: 0)
    }
    
    public
    func fitWidth(offset: CGFloat) -> CGFloat {
        if let cons = self.widthConstraint {
            cons.constant = self.sizeThatFits(CGSize(width: 99999, height: (self.titleLabel?.font.pointSize ?? 0) * 1.5)).width + offset
            return cons.constant;
        }else{
            return 0
        }
    }
}


