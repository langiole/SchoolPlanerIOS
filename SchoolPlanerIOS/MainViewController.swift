//
//  MainViewController.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 7/14/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courses = []
        courses.append(Course(courseName: "Science", courseColor: UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0)))
        courses.append(Course(courseName: "Math", courseColor: UIColor(red:0.75, green:0.22, blue:0.17, alpha:1.0)))
        courses.append(Course(courseName: "Computer Science", courseColor: UIColor(red:0.90, green:0.49, blue:0.13, alpha:1.0)))
        courses.append(Course(courseName: "English", courseColor: UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.0)))
        
       
        
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 50, 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath) as! CourseTableViewCell
        
        // configure cell
        cell.backgroundColor = UIColor.clearColor()
        cell.setupViewWithColor(courses[indexPath.row].courseColor)
        cell.layer.masksToBounds = true
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.infoLabel.text = "1 Homework Assignment"
        cell.courseLabel.text = courses[indexPath.row].courseName
        cell.setButton()

        return cell
    }
    
    var extendedIndexPath: NSIndexPath!
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.beginUpdates()
        let indexPath = tableView.indexPathForSelectedRow
        let cell = self.tableView.cellForRowAtIndexPath(indexPath!) as! CourseTableViewCell
        print("select")
        if extendedIndexPath == indexPath {
            extendedIndexPath = nil
            cell.settingsButton.hidden = true
        }
        else {
            extendedIndexPath = indexPath
            cell.popButtonIn()
        }
        
        self.tableView.endUpdates()
        
        if extendedIndexPath == indexPath {
            tableView.scrollToRowAtIndexPath(indexPath!, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
            self.tableView.reloadData()
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
