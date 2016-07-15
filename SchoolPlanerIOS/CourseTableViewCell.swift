//
//  CourseTableViewCell.swift
//  SchoolPlanerIOS
//
//  Created by Lee Angioletti on 7/14/16.
//  Copyright © 2016 Lee Angioletti. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var colors = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor()]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        configureScrollView()
        configurePageControl()
    }
    
    func setupViewWithColor(color: UIColor) {
        courseView.layer.cornerRadius = 10
        courseView.layer.masksToBounds = true
        courseView.backgroundColor = color
    }
    
    func setButton() {
        let origImage = UIImage(named: "settings_icon");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        settingsButton.setImage(tintedImage, forState: .Normal)
    }
    
    func popButtonIn() {
        self.settingsButton.hidden = false
        settingsButton.imageView?.transform = CGAffineTransformMakeScale(0.01, 0.01)
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.settingsButton.imageView?.transform = CGAffineTransformIdentity
            
            }, completion: {finished in

        })
    }
    
    func configureScrollView() {
        // Enable paging.
        scrollView.pagingEnabled = true
        
        // Set the following flag values.
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        // Set the scrollview content size.
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(3), scrollView.frame.size.height)
        
        // Set self as the delegate of the scrollview.
        scrollView.delegate = self
        
        // Load the TestView view from the TestView.xib file and configure it properly.
//        for var i=0; i<3; ++i {
//            // Load the TestView view.
//            let testView = NSBundle.mainBundle().loadNibNamed("TestView", owner: self, options: nil)[0] as! UIView
//            
//            // Set its frame and the background color.
//            testView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
//            testView.backgroundColor = colors[i]
//            
//            // Set the proper message to the test view's label.
//            let label = testView.viewWithTag(1) as! UILabel
//            label.text = "Page #\(i + 1)"
//            
//            // Add the test view as a subview to the scrollview.
//            scrollView.addSubview(testView)
//        }
    }
    
    func configurePageControl() {
        // Set the total pages to the page control.
        pageControl.numberOfPages = colors.count
        
        // Set the initial page.
        pageControl.currentPage = 0
    }
    
    @IBAction func changePage(sender: AnyObject) {
        // Calculate the frame that should scroll to based on the page control current page.
        var newFrame = scrollView.frame
        newFrame.origin.x = newFrame.size.width * CGFloat(pageControl.currentPage)
        scrollView.scrollRectToVisible(newFrame, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Calculate the new page index depending on the content offset.
        let currentPage = floor(scrollView.contentOffset.x / UIScreen.mainScreen().bounds.size.width);
        
        // Set the new page index to the page control.
        pageControl.currentPage = Int(currentPage)
    }
    
}
