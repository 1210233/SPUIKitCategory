//
//  UIView+SPFunctions.swift
//  WenYanWen
//
//  Created by Bee on 2020/12/15.
//

import UIKit

public let screenWidthScaleBase375: CGFloat = {
    var scale: CGFloat = 1
    let o = UIApplication.shared.statusBarOrientation
    
    if (o.isPortrait) {
        scale = UIScreen.main.bounds.size.width / 375
    }else if (o.isLandscape) {
        scale = UIScreen.main.bounds.size.height / 375
    }
    return scale
}()

