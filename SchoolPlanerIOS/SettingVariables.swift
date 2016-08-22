//
//  SettingVariables.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 8/5/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

class SettingVariables {
    static let sharedInstance = SettingVariables()
    
    //var assignmentArr = [[Assignment]]()
    var courseArr = [Course]()
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    private init() { }
}