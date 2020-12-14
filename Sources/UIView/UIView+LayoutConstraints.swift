//
//  File.swift
//  
//
//  Created by LSP on 2020/12/11.
//

import UIKit


extension UIView {
    
    var constraintsForOtherViews: NSMutableDictionary {
        get {
            if let dic = objc_getAssociatedObject(self, "constraintsForOtherViews") as? NSMutableDictionary {
                return dic
            } else {
                let dic = NSMutableDictionary()
                objc_setAssociatedObject(self, "constraintsForOtherViews", dic, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return dic
            }
        }
    }
    var storedConstraintsKey: String {
        if let key = objc_getAssociatedObject(self, "storedConstraintsKey") as? String {
            return key
        } else {
            let key = String(format: "%p", self)
            objc_setAssociatedObject(self, "storedConstraintsKey", key, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            return key
        }
    }
    func constraintsDicFor(view: UIView) -> NSMutableDictionary {
        if let dic = self.constraintsForOtherViews[view.storedConstraintsKey] as? NSMutableDictionary {
            return dic
        } else {
            let dic = NSMutableDictionary()
            self.constraintsForOtherViews[view.storedConstraintsKey] = dic
            return dic
        }
    }
    
    
    
    
    /**
     本视图与另一视图view保持对齐。如果约束未设置则会自动创建(并让父视图调用addConstraint:使约束生效)。constant默认为0.
     leadingEqualToView: 视图的左边与view的左边保持对齐，设置constant则为两视图的左边所保持的距离。以下同理。
     topEqualToView:
     bottomEqualToView:
     leadingEqualToView:
     trailingEqualToView:
     widthEqualToView:
     heightEqualToView:
     centerXEqualToView:
     centerYEqualToView:
     
     @param view 被参照的视图。
     @param multiplier 比例。
     @return 所约束两个视图的约束对象。
     */
    func topEqualTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["top"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["top"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["top"] = cons
        }
        return cons!
    }
    
    func leadingEqualTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["leading"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["leading"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["leading"] = cons
        }
        return cons!
    }
    
    func trailingEqualTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["trailing"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["trailing"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["trailing"] = cons
        }
        return cons!
    }
    
    func bottomEqualTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["bottom"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["bottom"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["bottom"] = cons
        }
        return cons!
    }
    
    func widthEqualTo(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["width"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: multiplier, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["width"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["width"] = cons
        }
        return cons!
    }
    
    func heightEqualTo(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["height"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: multiplier, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["height"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["height"] = cons
        }
        return cons!
    }
    
    func centerXEqualTo(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["centerX"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: multiplier, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["centerX"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["centerX"] = cons
        }
        return cons!
    }
    
    func centerYEqualTo(view: UIView, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["centerY"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: multiplier, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["centerY"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["centerY"] = cons
        }
        return cons!
    }
    
    func leadingSpacingTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["left_spacing"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["left_spacing"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["right_spacing"] = cons
        }
        return cons!
    }
    
    func trailingSpacingTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["right_spacing"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["right_spacing"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["left_spacing"] = cons
        }
        return cons!
    }
    
    func topSpacingTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["top_spacing"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["top_spacing"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["bottom_spacing"] = cons
        }
        return cons!
    }
    
    func centerYEqualTo(view: UIView) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["bottom_spacing"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            self.superview?.addConstraint(cons!)
            dic["bottom_spacing"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["top_spacing"] = cons
        }
        return cons!
    }
    
    /* *********************************************************************************** */
    /* ***** Getter ***** Getter ***** Getter ***** Getter ***** Getter ***** Getter ***** */
    /* *********************************************************************************** */
    /**
     本视图宽度的约束. 如果在XIB中已创建该约束，则会自动关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
     */
    @IBOutlet
    var widthConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "widthConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "widthConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var widthConstant: CGFloat {
        get {
            return self.widthConstraint?.constant ?? 0;
        }
        set {
            if let cons = objc_getAssociatedObject(self, "widthConstraint") as? NSLayoutConstraint {
                cons.constant = newValue;
            }else{
                self.makeWidthConstraint(newValue)
            }
        }
    }
    
    @discardableResult
    func makeWidthConstraint(_ width: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        
        self.addConstraint(constraint)
        self.widthConstraint = constraint
        return constraint;
    }
    
    
    
    
    
}

