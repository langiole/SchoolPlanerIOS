//
//  Course.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 7/14/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

class Course {
    
    var name: String!
    var color: UIColor!
    var assignments = [[Assignment]]()
    
    init(name: String) {
        self.name = name
        self.color = UIColor.whiteColor()
    }
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
    
}