//
//  UIButton+AutoLayoutFitSize.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/11.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

/**
 *  使用此分类的API, 需要预先设置宽度约束或高度约束.
 *  宽度/高度约束在 "UIView+Constraints.h" 中定义.
 *  设置约束时, 可在XIB或StoryBoard中关联, 也可以
 *  用代码初始化, 调用Setter即可.
 */
extension UIButton {
    /**
     *  根据文本内容计算宽度并用约束来控制frame.(单行)
     *  @param os: [文本所占的宽度 + os] 即为frame的宽度. 范围:[FLT_MIN ~ FLT_MAX]
     *  @return 计算后的宽度值
     */
    public
    func fitWidth(offset: CGFloat = 0) -> CGFloat {
        if let cons = self.widthConstraint {
            cons.constant = self.sizeThatFits(CGSize(width: 99999, height: (self.titleLabel?.font.pointSize ?? 0) * 1.5)).width + offset
            return cons.constant;
        }else{
            return 0
        }
    }
}
#endif

