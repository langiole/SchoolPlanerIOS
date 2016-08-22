//
//  MainViewController.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 7/14/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CourseTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var settingVars = SettingVariables.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingVars.courseArr.append(Course(name: "Math", color: UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)))
        settingVars.courseArr.append(Course(name: "English", color: UIColor(red:0.75, green:0.22, blue:0.17, alpha:1.0)))
        settingVars.courseArr.append(Course(name: "Computer Science", color: UIColor(red:0.90, green:0.49, blue:0.13, alpha:1.0)))
        
        for course in settingVars.courseArr {
            for i in 0...AssignmentTypes.allValues.count - 1 {
                var arr = [Assignment]()
                for j in 0...2 {
                    let type = AssignmentTypes.allValues[i]
                    let name = type.rawValue + " " + String(j) + course.name
                    arr.append(Assignment(name: name, type: type))
                }
                course.assignments.append(arr)
            }
        }
        
        self.tableView.backgroundColor = UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingVars.courseArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as! CourseTableViewCell

        // configure cell
        cell.backgroundColor = UIColor.clearColor()
        cell.assignments = settingVars.courseArr[indexPath.row].assignments
        cell.setupViewWithColor(settingVars.courseArr[indexPath.row].color)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.courseLabel.text = settingVars.courseArr[indexPath.row].name
        cell.delegate = self
        return cell
    }
    
    var extendedIndexPath: NSIndexPath!
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.beginUpdates()
        let indexPath = tableView.indexPathForSelectedRow
        let cell = self.tableView.cellForRowAtIndexPath(indexPath!) as! CourseTableViewCell
        
        // selected cell is already selected - CELL COLLAPSES
        if extendedIndexPath == indexPath {
            extendedIndexPath = nil
            cell.collapsedView()
        }
        // cell is selected
        else {
            // another cell is selected - CELL EXPANDS / PREV CELL CLOSES
            if extendedIndexPath != nil {
                let prevCell = self.tableView.cellForRowAtIndexPath(extendedIndexPath!) as! CourseTableViewCell
                extendedIndexPath = indexPath
                prevCell.collapsedView()
                cell.expandedView()
            }
            // new cell is selected - CELL EXPANDS
            else {
                extendedIndexPath = indexPath
                cell.expandedView()
            }
        }
        
        self.tableView.endUpdates()

        
        // update table again to scroll to selected cell
        if extendedIndexPath == indexPath {
            tableView.scrollToRowAtIndexPath(indexPath!, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
        }

    }
    
    func getEmptyTap(tap: UITapGestureRecognizer) {
        print("2")
        let location = tap.locationInView(self.tableView)
        let path = self.tableView.indexPathForRowAtPoint(location)
        if let indexPathForRow = path {
            self.tableView(self.tableView, didSelectRowAtIndexPath: indexPathForRow)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if extendedIndexPath != nil && extendedIndexPath == indexPath {
            return self.tableView.frame.height * 0.75
        }
        else {
            return self.tableView.rowHeight
        }
    }
    

    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
