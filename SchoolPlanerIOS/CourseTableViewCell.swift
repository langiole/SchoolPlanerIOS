//
//  CourseTableViewCell.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 7/14/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

protocol CourseTableViewCellDelegate {
    func getEmptyTap(tap: UITapGestureRecognizer)
}

class CourseTableViewCell: UITableViewCell, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {

    var delegate: CourseTableViewCellDelegate?
    
    var scrollView: UIScrollView!
    var tapGesture: UITapGestureRecognizer!
    var courseLabel: UILabel!
    var settingsButton: UIButton!
    var mainView: UIView!
    var homework1 = Assignment(name: "test", type: AssignmentTypes.Homework)
    
    var menuBar: UIScrollView!
    
    var colors = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()]
    var assignments = [[Assignment]]()

    var tableViewArr = [UITableView]()
    
    var courseView: UIView!
    var color = UIColor.redColor()
    
    var menuBarButtons = [UIButton]()
    
    var cellID: String!
    
    var settingVars = SettingVariables.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFrames()
    }
    
    override func layoutSubviews() {
        
        
        hideSeperator()
        mainView.layer.cornerRadius = 25
        mainView.layer.masksToBounds = true
        courseView.roundCorners([.BottomLeft, .BottomRight], radius: 25)

    }
    
    func hideSeperator() {
        for i in 0...tableViewArr.count - 1 {
            tableViewArr[i].separatorStyle = .None
            tableViewArr[i].layer.cornerRadius = 10
            tableViewArr[i].clipsToBounds = true
        }
    }
    
    func initFrames() {
        
        // init frames
        mainView = UIView()
        courseView = UIView()
        scrollView = UIScrollView()
        courseLabel = UILabel()
        settingsButton = UIButton(type: .System)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        menuBar = UIScrollView()
        
        // add to respective views
        addSubview(mainView)
        addSubview(courseView)
        mainView.addSubview(scrollView)
        courseView.addSubview(courseLabel)
        courseView.addSubview(settingsButton)
        mainView.addSubview(menuBar)
        for i in 0...AssignmentTypes.allValues.count - 1 {
            let tableView = UITableView()
            tableViewArr.append(tableView)
            scrollView.addSubview(tableViewArr[i])
        }

        // set constraints
        courseView.translatesAutoresizingMaskIntoConstraints = false
        courseView.leadingAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.leadingAnchor).active = true
        courseView.trailingAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.trailingAnchor).active = true
        courseView.topAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.bottomAnchor, constant: -40).active = true
        courseView.bottomAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.bottomAnchor).active = true
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.leadingAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.leadingAnchor).active = true
        mainView.trailingAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.trailingAnchor).active = true
        mainView.topAnchor.constraintEqualToAnchor(self.layoutMarginsGuide.topAnchor).active = true
        mainView.bottomAnchor.constraintEqualToAnchor(courseView.layoutMarginsGuide.bottomAnchor).active = true
        mainView.backgroundColor = UIColor.whiteColor()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraintEqualToAnchor(courseView.layoutMarginsGuide.leadingAnchor).active = true
        scrollView.trailingAnchor.constraintEqualToAnchor(courseView.layoutMarginsGuide.trailingAnchor).active = true
        //scrollView.topAnchor.constraintEqualToAnchor(menuBar.layoutMarginsGuide.bottomAnchor).active = true
        scrollView.bottomAnchor.constraintEqualToAnchor(courseView.topAnchor).active = true
        
        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        courseLabel.centerXAnchor.constraintEqualToAnchor(courseView.centerXAnchor).active = true
        courseLabel.centerYAnchor.constraintEqualToAnchor(courseView.centerYAnchor).active = true
//        courseLabel.leadingAnchor.constraintEqualToAnchor(courseView.leadingAnchor, constant: 20).active = true
//        courseLabel.topAnchor.constraintEqualToAnchor(courseView.topAnchor, constant: 20).active = true
        courseLabel.font = UIFont.systemFontOfSize(18)
        courseLabel.textColor = UIColor.whiteColor()
        
        for i in 0...tableViewArr.count - 1 {
            if i == 0 {
                tableViewArr[i].translatesAutoresizingMaskIntoConstraints = false
                tableViewArr[i].leadingAnchor.constraintEqualToAnchor(scrollView.layoutMarginsGuide.leadingAnchor).active = true
                tableViewArr[i].trailingAnchor.constraintEqualToAnchor(scrollView.layoutMarginsGuide.trailingAnchor).active = true
                tableViewArr[i].topAnchor.constraintEqualToAnchor(menuBar.layoutMarginsGuide.bottomAnchor).active = true
                tableViewArr[i].bottomAnchor.constraintEqualToAnchor(scrollView.layoutMarginsGuide.bottomAnchor).active = true
            }
            else {
                tableViewArr[i].translatesAutoresizingMaskIntoConstraints = false
                tableViewArr[i].centerXAnchor.constraintEqualToAnchor(tableViewArr[i - 1].layoutMarginsGuide.centerXAnchor).active = true
                tableViewArr[i].centerYAnchor.constraintEqualToAnchor(tableViewArr[i - 1].layoutMarginsGuide.centerYAnchor).active = true
                tableViewArr[i].widthAnchor.constraintEqualToAnchor(tableViewArr[i - 1].widthAnchor, multiplier: 1.0).active = true
                tableViewArr[i].heightAnchor.constraintEqualToAnchor(tableViewArr[i - 1].heightAnchor, multiplier: 1.0).active = true
            }
        }
        
    
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.centerYAnchor.constraintEqualToAnchor(courseLabel.centerYAnchor).active = true
        settingsButton.trailingAnchor.constraintEqualToAnchor(courseView.layoutMarginsGuide.trailingAnchor, constant: -5).active = true
        settingsButton.setImage(UIImage(named: "settings_icon"), forState: .Normal)
        settingsButton.tintColor = UIColor.whiteColor()
        settingsButton.hidden = true
        settingsButton.addTarget(self, action: "settingsButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.leadingAnchor.constraintEqualToAnchor(scrollView.layoutMarginsGuide.leadingAnchor).active = true
        menuBar.trailingAnchor.constraintEqualToAnchor(scrollView.layoutMarginsGuide.trailingAnchor).active = true
        menuBar.topAnchor.constraintEqualToAnchor(scrollView.layoutMarginsGuide.topAnchor).active = true
        menuBar.heightAnchor.constraintEqualToConstant(40).active = true
        
        // configure views
        // add rounded corners to courseView
//        courseView.layer.cornerRadius = 25
//        courseView.layer.masksToBounds = true
        
        
        
    }
    
    func configureMenuBar() {
        menuBar.showsHorizontalScrollIndicator = false
        menuBar.scrollEnabled = false
        
        var width = CGFloat(60)
        let buffer = CGFloat(20)
        for subject in AssignmentTypes.allValues {
            let button = UIButton(type: .Custom)
            button.setTitle(subject.rawValue, forState: .Normal)
            button.setTitleColor(UIColor.init(white: 1.0, alpha: 0.50), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(UIFont.systemFontSize(), weight: UIFontWeightThin)
            button.sizeToFit()
            button.frame.origin.x = width
            button.center.y = 20
            menuBarButtons.append(button)
            menuBar.addSubview(button)
            width += button.frame.width + buffer
            button.addTarget(self, action: #selector(self.changeButton(_:)), forControlEvents: .TouchUpInside)
        }
        width = ((width + 60) - buffer)
        menuBar.contentSize = CGSizeMake(width, 40)
        
        menuBar.delegate = self
        
    }
    
    func changeButton(sender: UIButton) {
        let pageNumber = self.menuBarButtons.indexOf(sender)!
        
        // change tableview center
        if round(scrollView.contentOffset.x / scrollView.frame.size.width) != CGFloat(pageNumber) {
            self.changeTableView(pageNumber)
        }

        // center button
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseIn, animations: {
            // center the button
            self.menuBar.contentOffset.x = sender.center.x - (self.menuBar.bounds.width / 2)
            // change button highlight
            for button in self.menuBarButtons {
                if button.isEqual(sender) {
                    button.titleLabel?.textColor = UIColor.init(white: 1.0, alpha: 1.0)
                    button.setTitleColor(UIColor.init(white: 1.0, alpha: 1.0), forState: .Normal)
                }
                else {
                    button.titleLabel?.textColor = UIColor.init(white: 1.0, alpha: 0.50)
                }
            }
            }, completion: { _ in
        })
    }
    
    func configureCourseView() {
        courseView.center = self.contentView.center
        courseView.layer.cornerRadius = 25
        courseView.layer.masksToBounds = true
    }
    
    func configureViews() {
        configureScrollView()
        configureMenuBar()
        
        // hide views
        scrollView.hidden = true
        menuBar.hidden = true
    }
    
    func setupViewWithColor(color: UIColor) {
        configureViews()
        courseView.backgroundColor = color
        mainView.backgroundColor = color.lighterColorForColor(color)
        menuBar.backgroundColor = color.lighterColorForColor(color)
        scrollView.backgroundColor = UIColor.clearColor()
        for i in 0...tableViewArr.count - 1 {
            tableViewArr[i].backgroundColor = UIColor.clearColor()
        }
    }
    
    func configureScrollView() {
        
        // Enable paging.
        scrollView.pagingEnabled = true
        
        // Set the following flag values.
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false

        // set tablevies delegate, datasource, and register
        for i in 0...tableViewArr.count - 1 {
            tableViewArr[i].separatorColor = UIColor.redColor()
            tableViewArr[i].dataSource = self
            tableViewArr[i].delegate = self
            tableViewArr[i].registerClass(DetailTableViewCell.classForKeyedArchiver(), forCellReuseIdentifier: "cell")
            let tap = UITapGestureRecognizer(target: self, action: #selector(emptyTapped))
            self.tableViewArr[i].addGestureRecognizer(tap)
        }
        
        // Set self as the delegate of the scrollview.
        scrollView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows = 0
        for i in 0...tableViewArr.count - 1 {
            if tableViewArr[i].isEqual(tableView) {
                numOfRows = assignments[i].count
            }
        }
        
        return numOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var tableViewIndex = 0
        for i in 0...tableViewArr.count - 1 {
            if tableViewArr[i].isEqual(tableView) {
                tableViewIndex = i
            }
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.label.text = assignments[tableViewIndex][indexPath.row].name
        cell.label.textColor = UIColor.whiteColor()
        cell.label.backgroundColor = UIColor().lighterColorForColor(self.courseView.backgroundColor!)
        cell.backgroundColor = UIColor().lighterColorForColor(self.courseView.backgroundColor!)
        return cell
    }
    
    func emptyTapped(tap: UITapGestureRecognizer) {
        print("1")
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        let location = tap.locationInView(tableViewArr[pageNumber])
        let path = tableViewArr[pageNumber].indexPathForRowAtPoint(location)
        if path == nil {
            delegate?.getEmptyTap(tap)
        }
    }
    
    var extendedIndexPath: NSIndexPath!
    var height: CGFloat!
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        //height = tableView.cellForRowAtIndexPath(indexPath)?.bounds.height
        //tableView.beginUpdates()
        //let indexPath = tableView.indexPathForSelectedRow
        //let cell = tableView.cellForRowAtIndexPath(indexPath!) as! DetailTableViewCell
//        // first row is tapped; add new cell
//        if indexPath!.row == 0 {
//            homework.insert("new", atIndex: 1)
//            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: indexPath!.section)], withRowAnimation: .Top)
//        }
//        else {
//            //selected cell is already selected - CELL COLLAPSES
//            if extendedIndexPath == indexPath {
//                extendedIndexPath = nil
//                cell.contracted()
//            }
//                // cell is selected
//            else {
//                // another cell is selected - CELL EXPANDS / PREV CELL CLOSES
//                if extendedIndexPath != nil {
//                    let prevCell = tableView.cellForRowAtIndexPath(extendedIndexPath!) as! DetailTableViewCell
//                    extendedIndexPath = indexPath
//                    prevCell.contracted()
//                    cell.expanded()
//                }
//                    // new cell is selected - CELL EXPANDS
//                else {
//                    extendedIndexPath = indexPath
//                    cell.expanded()
//                }
//            }
//        }
//        tableView.endUpdates()
//
//        // scroll to cell if selected out of view
//        if extendedIndexPath == indexPath && extendedIndexPath.row == homework.count - 1 {
//            tableView.scrollToRowAtIndexPath(indexPath!, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
//        }
//        else {
//            tableView.scrollRectToVisible(cell.frame, animated: true)
//        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if extendedIndexPath != nil && extendedIndexPath == indexPath {
            return height * 2
        }
        else {
            return 60
        }
    }
    
    func expandedView() {
        self.scrollView.topAnchor.constraintEqualToAnchor(self.mainView.topAnchor).active = true
        
        // reset centerX anchor for tableviews
        for i in 0...tableViewArr.count - 1 {
            if i != 0 {
                tableViewArr[i].centerXAnchor.constraintEqualToAnchor(tableViewArr[i - 1].centerXAnchor, constant: scrollView.bounds.width).active = true
            }
            tableViewArr[i].reloadData()
        }
        scrollView.contentSize = CGSize(width: (scrollView.bounds.width * CGFloat(tableViewArr.count)), height: scrollView.bounds.height)
        scrollView.hidden = false
        settingsButton.hidden = false
        menuBar.hidden = false
        changeButton(menuBarButtons[0])
    }
    
    func collapsedView() {
        scrollView.hidden = true
        settingsButton.hidden = true
        menuBar.hidden = true
    }
    
    var lastContentOffset: CGPoint!

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        if lastContentOffset.x < CGFloat(scrollView.contentOffset.x) {
            changeButton(menuBarButtons[Int(pageNumber)])
        }
        else if lastContentOffset.x > CGFloat(scrollView.contentOffset.x) {
            changeButton(menuBarButtons[Int(pageNumber)])
        }
    }
    
    func changeTableView(pageNumber: Int) {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseIn, animations: {
            // change the view
            self.scrollView.contentOffset.x = CGFloat(pageNumber) * self.scrollView.frame.size.width
            
            }, completion: { _ in
                
        })
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let off = self.scrollView.contentOffset.x / 7.0
        menuBar.contentOffset.x = off
//        print(scrollView)
//        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
//        //self.menuBar.contentOffset.x = sender.center.x - (self.menuBar.bounds.width / 2)
//        //menuBar.contentOffset.x = (menuBarButtons[pageNumber+1].center.x - (menuBar.bounds.width / 2)) * (scrollView.contentOffset.x / scrollView.bounds.width)
//        let wid2 = self.scrollView.contentOffset.x / self.scrollView.bounds.width
//        var wid3 = CGFloat(0.1)
//        if lastContentOffset.x < CGFloat(scrollView.contentOffset.x) {
//            wid3 = wid2 * (menuBarButtons[pageNumber + 1].center.x - (self.menuBar.bounds.width / 2))
//        }
//        else if lastContentOffset.x > CGFloat(scrollView.contentOffset.x) {
//            wid3 = (1.0 - wid2) * (menuBarButtons[pageNumber].center.x - (self.menuBar.bounds.width / 2))
//        }
//        menuBar.contentOffset.x += wid3
//        print(wid3)
//        print("------")
        //menuBar.contentOffset.x = wid3
        //print("here",(menuBarButtons[pageNumber+1].center.x - (menuBar.bounds.width / 2)) * (scrollView.contentOffset.x / scrollView.bounds.width))
    }
    
    func settingsButtonTapped() {
        print("worked")
    }
    
}
