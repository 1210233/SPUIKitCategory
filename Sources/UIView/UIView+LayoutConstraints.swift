//
//  UIView+LayoutConstraints.swift
//  SPUIKitCategory module
//
//  Created by LSP on 2020/12/11.
//  Copyright © 2020 LSP. All rights reserved.
//

#if !os(macOS)
import UIKit

@objc
extension UIView {
    
    private
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
    
    private
    var storedConstraintsKey: String {
        if let key = objc_getAssociatedObject(self, "storedConstraintsKey") as? String {
            return key
        } else {
            let key = String(format: "%p", self)
            objc_setAssociatedObject(self, "storedConstraintsKey", key, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            return key
        }
    }
    
    private
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
    public
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
    
    public
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
    
    public
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
    
    public
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
    
    public
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
    
    public
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
    
    public
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
    
    public
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
    
    
    /**
     本视图与另一视图view保持的距离。如果约束未设置则会自动创建(并让父视图调用addConstraint:使约束生效)。
     leadingSpacingToView:  视图的左边与view的右边保持的距离，设置constant则为本视图的左边与view的右边所保持的距离。
     trailingSpacingToView: 视图的右边与view的左边保持的距离，设置constant则为本视图的右边与view的左边所保持的距离。
     topSpacingToView:      视图的顶部与view的底部保持的距离，设置constant则为本视图的顶部与view的底部所保持的距离。
     bottomSpacingToView:   视图的底部与view的顶部保持的距离，设置constant则为本视图的底部与view的顶部所保持的距离。
     
     @param view 被参照的视图。
     @return 所约束两个视图的约束对象。
     */
    public
    func leadingSpacingTo(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
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
        }else{
            cons!.constant = constant
        }
        return cons!
    }
    
    public
    func trailingSpacingTo(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
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
        }else{
            cons!.constant = constant
        }
        return cons!
    }
    
    public
    func topSpacingTo(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
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
        }else{
            cons!.constant = constant
        }
        return cons!
    }
    
    public
    func bottomSpacingTo(view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        var dic = self.constraintsDicFor(view: view)
        var cons = dic["bottom_spacing"] as? NSLayoutConstraint
        if cons == nil {
            if self.translatesAutoresizingMaskIntoConstraints {
                self.translatesAutoresizingMaskIntoConstraints = false
            }
            
            cons = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: constant)
            self.superview?.addConstraint(cons!)
            dic["bottom_spacing"] = cons
            dic = view.constraintsDicFor(view: self)
            dic["top_spacing"] = cons
        }else{
            cons!.constant = constant
        }
        return cons!
    }
    
    
    /* *********************************************************************************** */
    /* ***** Getter ***** Getter ***** Getter ***** Getter ***** Getter ***** Getter ***** */
    /* *********************************************************************************** */
    /**
     本视图宽度的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
     */
    @IBOutlet public
    var widthConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "widthConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "widthConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var widthConstant: CGFloat {
        get {
            return self.widthConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.widthConstraint {
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
    
    
    /**
     本视图高度的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
    */
    @IBOutlet public
    var heightConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "heightConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "heightConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var heightConstant: CGFloat {
        get {
            return self.heightConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.heightConstraint {
                cons.constant = newValue;
            }else{
                self.makeHeightConstraint(newValue)
            }
        }
    }
    @discardableResult
    func makeHeightConstraint(_ height: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        
        self.addConstraint(constraint)
        self.heightConstraint = constraint
        return constraint;
    }
    
    
    /**
     本视图顶部距离父视图的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
     */
    @IBOutlet public
    var topConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "topConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "topConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var topConstant: CGFloat {
        get {
            return self.topConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.topConstraint {
                cons.constant = newValue;
            }else{
                self.makeTopConstraint(newValue)
            }
        }
    }
    @discardableResult
    func makeTopConstraint(_ top: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: top)
        
        self.superview?.addConstraint(constraint)
        self.topConstraint = constraint
        return constraint;
    }
    
    
    /**
     本视图左边距离父视图的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
    */
    @IBOutlet public
    var leftConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "leftConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "leftConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var leftConstant: CGFloat {
        get {
            return self.leftConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.leftConstraint {
                cons.constant = newValue;
            }else{
                self.makeLeftConstraint(newValue)
            }
        }
    }
    @discardableResult
    func makeLeftConstraint(_ left: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1, constant: left)
        
        self.superview?.addConstraint(constraint)
        self.leftConstraint = constraint
        return constraint;
    }
    
    
    /**
     本视图右边距离父视图的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
    */
    @IBOutlet public
    var rightConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "rightConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "rightConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var rightConstant: CGFloat {
        get {
            return self.rightConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.rightConstraint {
                cons.constant = newValue;
            }else{
                self.makeRightConstraint(newValue)
            }
        }
    }
    @discardableResult
    func makeRightConstraint(_ right: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview, attribute: .trailing, multiplier: 1, constant: right)
        
        self.superview?.addConstraint(constraint)
        self.rightConstraint = constraint
        return constraint;
    }
    
    
    /**
     本视图底部距离父视图的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
    */
    @IBOutlet public
    var bottomConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "bottomConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "bottomConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var bottomConstant: CGFloat {
        get {
            return self.bottomConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.bottomConstraint {
                cons.constant = newValue;
            }else{
                self.makeBottomConstraint(newValue)
            }
        }
    }
    @discardableResult
    func makeBottomConstraint(_ bottom: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1, constant: bottom)
        
        self.superview?.addConstraint(constraint)
        self.bottomConstraint = constraint
        return constraint;
    }
    
    
    /**
     本视图与父视图水平放心中心对齐的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
     */
    @IBOutlet public
    var centerXConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "centerXConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "centerXConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var centerXConstant: CGFloat {
        get {
            return self.centerXConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.centerXConstraint {
                cons.constant = newValue;
            }else{
                self.makeCenterXConstraint(newValue)
            }
        }
    }
    @discardableResult
    func makeCenterXConstraint(_ centerX: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: self.superview, attribute: .centerX, multiplier: 1, constant: centerX)
        
        self.superview?.addConstraint(constraint)
        self.centerXConstraint = constraint
        return constraint;
    }

    /**
     本视图与父视图竖直放心中心对齐的约束. 如果在XIB中已创建该约束，可连线关联到本属性。
     若未创建，则在调用getter时会自动创建，默认constant为0.
     */
    @IBOutlet public
    var centerYConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, "centerYConstraint") as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, "centerYConstraint", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    @IBInspectable public
    var centerYConstant: CGFloat {
        get {
            return self.centerYConstraint?.constant ?? 0;
        }
        set {
            if let cons = self.centerYConstraint {
                cons.constant = newValue;
            }else{
                self.makeCenterYConstraint(newValue)
            }
        }
    }
    @discardableResult
    func makeCenterYConstraint(_ centerY: CGFloat) -> NSLayoutConstraint {
        if (self.translatesAutoresizingMaskIntoConstraints) {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: self.superview, attribute: .centerY, multiplier: 1, constant: centerY)
        
        self.superview?.addConstraint(constraint)
        self.centerYConstraint = constraint
        return constraint;
    }
}


@objc
extension NSLayoutConstraint {
    /// 需要交换的方法名
    var autoScaleExchangeMethodNames: [String] {
        return ["setConstant:"]
    }
    
    
    func sp_setConstant(_ constant: CGFloat) {
        if (self.autoScale) {
            return self.sp_setConstant(constant * screenWidthScaleBase375)
        }
        return self.sp_setConstant(constant)
    }
 
    /// 是否自动根据375屏幕宽度进行缩放constant的值.
    @IBInspectable public
    var autoScale: Bool {
        get {
            if let v = objc_getAssociatedObject(self, "autoScale") as? NSNumber {
                return v.boolValue
            }
            return false
        }
        set {
            if newValue == self.autoScale {
                return
            }
            
            objc_setAssociatedObject(self, "autoScale", NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if self.constant == 0 {
                return
            }
            
            if newValue {
                self.sp_setConstant(self.constant * screenWidthScaleBase375)
            }else{
                self.sp_setConstant(self.constant / screenWidthScaleBase375)
            }
        }
    }

}
#endif
