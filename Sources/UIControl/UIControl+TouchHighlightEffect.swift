//
//  UIControl+TouchHighlightEffect.swift
//  WenYanWen
//
//  Created by Bee on 2020/12/22.
//

import UIKit

@objc
extension UIControl {
    
    func _addHighlightEffectOnTouch() {
        if self.unHighlightedBackgroundColor == nil {
            self.unHighlightedBackgroundColor = self.backgroundColor;
        }
        
        self.addTarget(self, action: #selector(touchNeedsHighlighted), for: [.touchDown, .touchDragEnter])
        self.addTarget(self, action: #selector(touchNeedsCancelHighlighted), for: [.touchCancel, .touchDragExit, .touchUpInside])
    }

    func _removeHighlightEffectOnTouch() {
        self.removeTarget(self, action: #selector(touchNeedsHighlighted), for: .allEvents)
        self.removeTarget(self, action: #selector(touchNeedsCancelHighlighted), for: .allEvents)
    }



    func touchNeedsHighlighted() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseIn, .layoutSubviews, .allowUserInteraction], animations: {
            self.backgroundColor = self.highlightedBackgroundColor
        }, completion: nil)
    }

    func touchNeedsCancelHighlighted() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut, .layoutSubviews, .allowUserInteraction], animations: {
            self.backgroundColor = self.unHighlightedBackgroundColor
        }, completion: nil)
    }

    func touchNeedsAnimation() {
        self.backgroundColor = self.highlightedBackgroundColor;
        
        UIView.animate(withDuration: 0.15, delay: 0, options: [.layoutSubviews, .allowUserInteraction, .beginFromCurrentState], animations: {
            self.backgroundColor = self.unHighlightedBackgroundColor
        }, completion: nil)
    }
    
    
    
    /**
     是否在按下时候显示高亮效果. 默认：NO。
     */
    @IBInspectable
    var touchHighlightAble: Bool {
        get {
            if let v = objc_getAssociatedObject(self, "touchHighlightAble") as? NSNumber {
                return v.boolValue
            }
            return false
        }
        set {
            if newValue == touchHighlightAble {
                return
            }
            objc_setAssociatedObject(self, "touchHighlightAble", NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if newValue {
                
            } else {
                
            }
        }
    }
    /**
     高亮（按住）时的颜色
     */
    @IBInspectable
    var highlightedBackgroundColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, "highlightedBackgroundColor") as? UIColor {
                return color
            }
            let color = UIColor(white: 0.8, alpha: 0.5)
            self.highlightedBackgroundColor = color
            return color
        }
        set {
            objc_setAssociatedObject(self, "highlightedBackgroundColor", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    /**
     非高亮（松开）时的颜色
     */
    @IBInspectable
    var unHighlightedBackgroundColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, "unHighlightedBackgroundColor") as? UIColor
        }
        set {
            objc_setAssociatedObject(self, "unHighlightedBackgroundColor", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
