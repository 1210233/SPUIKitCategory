//
//  UIControl+TouchHighlightEffect.swift
//  SPUIKitCategory module
//
//  Created by Bee on 2020/12/22.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

@objc
extension UIControl {
    private
    func _addHighlightEffectOnTouch() {
        if self.unHighlightedBackgroundColor == nil {
            self.unHighlightedBackgroundColor = self.backgroundColor;
        }
        
        self.addTarget(self, action: #selector(touchNeedsHighlighted), for: [.touchDown, .touchDragEnter])
        self.addTarget(self, action: #selector(touchNeedsCancelHighlighted), for: [.touchCancel, .touchDragExit, .touchUpInside])
    }

    private
    func _removeHighlightEffectOnTouch() {
        self.removeTarget(self, action: #selector(touchNeedsHighlighted), for: .allEvents)
        self.removeTarget(self, action: #selector(touchNeedsCancelHighlighted), for: .allEvents)
    }


    private
    func touchNeedsHighlighted() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseIn, .layoutSubviews, .allowUserInteraction], animations: {
            self.backgroundColor = self.highlightedBackgroundColor
        }, completion: nil)
    }

    private
    func touchNeedsCancelHighlighted() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut, .layoutSubviews, .allowUserInteraction], animations: {
            self.backgroundColor = self.unHighlightedBackgroundColor
        }, completion: nil)
    }

    private
    func touchNeedsAnimation() {
        self.backgroundColor = self.highlightedBackgroundColor;
        
        UIView.animate(withDuration: 0.15, delay: 0, options: [.layoutSubviews, .allowUserInteraction, .beginFromCurrentState], animations: {
            self.backgroundColor = self.unHighlightedBackgroundColor
        }, completion: nil)
    }
    
    
    
    /**
     是否在按下时候显示高亮效果. 默认：NO。
     */
    @IBInspectable public
    var touchHighlightAble: Bool {
        get {
            if let v = objc_getAssociatedObject(self, &sp_touchHighlightAbleKey) as? NSNumber {
                return v.boolValue
            }
            return false
        }
        set {
            if newValue == self.touchHighlightAble {
                return
            }
            objc_setAssociatedObject(self, &sp_touchHighlightAbleKey, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if newValue {
                self._addHighlightEffectOnTouch()
            } else {
                self._removeHighlightEffectOnTouch()
            }
        }
    }
    /**
     高亮（按住）时的颜色
     */
    @IBInspectable public
    var highlightedBackgroundColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &sp_highlightedBackgroundColorKey) as? UIColor {
                return color
            }
            let color = UIColor(white: 0.8, alpha: 0.5)
            self.highlightedBackgroundColor = color
            return color
        }
        set {
            objc_setAssociatedObject(self, &sp_highlightedBackgroundColorKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    /**
     非高亮（松开）时的颜色
     */
    @IBInspectable public
    var unHighlightedBackgroundColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &sp_unHighlightedBackgroundColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &sp_unHighlightedBackgroundColorKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
#endif
