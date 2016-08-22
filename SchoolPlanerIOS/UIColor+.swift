//
//  UIColor+.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 8/2/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

extension UIColor {
    
    func lighterColorForColor(c: UIColor) -> UIColor {
        let comp = CGColorGetComponents(c.CGColor)
        var r = comp[0]
        var g = comp[1]
        var b = comp[2]
        var a = comp[3]
        if c.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
        }
        return UIColor.whiteColor()
    }
    
    func darkerColorForColor(c: UIColor) -> UIColor {
        let comp = CGColorGetComponents(c.CGColor)
        var r = comp[0]
        var g = comp[1]
        var b = comp[2]
        var a = comp[3]
        if c.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        return UIColor.whiteColor()
    }
}
