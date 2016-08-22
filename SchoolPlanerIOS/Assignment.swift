//
//  Homework.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 8/5/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

enum AssignmentTypes: String {
    case Homework = "HOMEWORK", Test = "TEST", Quiz = "QUIZ", Project = "PROJECT", Todo = "TODO"
    
    static let allValues = [Homework, Test, Quiz, Project, Todo]
}

class Assignment {
    
    var name: String!
    var details: String!
    var date: UIDatePicker!
    var type: AssignmentTypes!
    
    init(name: String, type: AssignmentTypes) {
        self.name = name
        self.type = type
    }
    
    init(name: String, details: String) {
        self.name = name
        self.details = details
    }
    
    init(name: String, details: String, date: UIDatePicker) {
        self.name = name
        self.details = details
        self.date = date
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setDetails(details: String) {
        self.details = details
    }
    
    func setDate(date: UIDatePicker) {
        self.date = date
    }
    
}