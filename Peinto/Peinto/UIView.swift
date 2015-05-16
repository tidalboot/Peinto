//
//  UIView.swift
//  Peinto
//
//  Created by Nick Jones on 27/04/2015.
//  Copyright (c) 2015 Nick Jones. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func absoluteCenterOfView (viewToUse: UIView) -> CGPoint {
        return CGPoint(x: viewToUse.frame.size.width / 2, y: viewToUse.frame.size.height / 2)
    }
    
    func horizontalCenterOfView (viewToUse: UIView) -> CGFloat {
        return viewToUse.frame.size.width / 2
    }
    
    func verticalCenterOfView (viewToUse: UIView) -> CGFloat {
        return viewToUse.frame.size.height / 2
    }
    
    func offsetFromBottomOfScreen (viewToUse: UIView, amountToOffsetBy: CGFloat) -> CGFloat {
        return viewToUse.frame.size.height - amountToOffsetBy
    }
}