//
//  MainTableViewController.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 7/14/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var courses = [String]!()

    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackgroundColor()
        courses = []
        courses.append("Science")
        courses.append("Math")
        courses.append("Computer Science")
        courses.append("English")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the  following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeBackgroundColor() {
        self.tableView.backgroundColor = UIColor.blackColor()
        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        let image = UIImage(named: "wallpaper1")
        let imageView = UIImageView(image: image)
        self.tableView.addSubview(blurEffectView)
        self.tableView.backgroundView = imageView
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "courseCard"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CourseTableViewCell

        // Configure the cell...
        cell.setupViewWithColor(UIColor.blueColor())
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.courseLabel.text = courses[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()

        return cell
    }
    
    var extendedIndexPath: NSIndexPath!
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.beginUpdates()
        let indexPath = tableView.indexPathForSelectedRow
        let cell = self.tableView.cellForRowAtIndexPath(indexPath!)
        
        if extendedIndexPath == indexPath {
            extendedIndexPath = nil
        }
        else {
            extendedIndexPath = indexPath
            var rect = self.tableView.rectForRowAtIndexPath(indexPath!)
        }
        
        self.tableView.endUpdates()

        if extendedIndexPath == indexPath {
            tableView.scrollToRowAtIndexPath(indexPath!, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if extendedIndexPath != nil && extendedIndexPath == indexPath {
            return 500
        }
        else {
            return self.tableView.rowHeight
        }
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
