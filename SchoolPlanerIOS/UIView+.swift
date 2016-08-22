//
//  UIView+.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 8/3/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}