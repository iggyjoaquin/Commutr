//
//  FirstViewController.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController {
    
    var minimumConstraint : CGFloat = 0.0
    var minimumHeight : CGFloat = 0.0
    
    var singleton = CommutrResources.sharedResources;
    var util : Utilities = Utilities()
    
    
    //subviews
    var timeSubview : PickTimeSubView? = nil
    var timeWindowSubview : TimeWindowSubView? = nil
    
    //outlets
    @IBOutlet weak var subviewsContainer: UIView!
    @IBOutlet weak var timePickerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    //actions


    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
        formatUI()
        
        
        //delegates and data sources
        tableView.delegate = self
        tableView.dataSource = self
        timeWindowSubview?.delegate = self
        
        //HACK
        let map = self.tabBarController?.viewControllers?[1] as? MapViewController
        map?.delegate = self
        
        
        //manually add items to test
        CommutrResources.sharedResources.addItem(title: "Highest points", points: 4.0, priority:10.0)
        CommutrResources.sharedResources.addItem(title: "Middle points", points: 2.0, priority:20.0)
        CommutrResources.sharedResources.addItem(title: "Least points", points: 1.0, priority:7.0)
        
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {

        minimumConstraint = timePickerBottomConstraint.constant
        minimumHeight = tableViewTopConstraint.constant
        tableView.reloadData()
        
        self.view.addSubview(subviewsContainer)
    }
    
    
    func loadSubviews() {
        let loadTimeSubview = PickTimeSubView.fromNib()
        subviewsContainer.addSubview(loadTimeSubview)
        loadTimeSubview.boundInside(subviewsContainer)
        timeSubview = loadTimeSubview
        
        //change text color of timepicker to white
        timeSubview?.timePicker.setValue(UIColor.white, forKeyPath: "textColor")
        timeSubview?.delegate = self
        
        let loadTimeLeftSubview = TimeWindowSubView.fromNib()
        subviewsContainer.addSubview(loadTimeLeftSubview )
        loadTimeLeftSubview.boundInside(subviewsContainer)
        timeWindowSubview = loadTimeLeftSubview
        
    }
    
    func formatUI() {
        timeWindowSubview?.isHidden = true
    }

}

extension FirstViewController : TimeWindowDelegate {
    func timeWindowSubviewDidTapReset(_ subview: TimeWindowSubView) {
        
        util.setView(view: timeWindowSubview!, hidden: true)
        util.setView(view: timeSubview!, hidden: false)
        //set time set to false
        CommutrResources.sharedResources.resetTime()
    
    }
}


extension FirstViewController: PickTimeDelegate {
    
    func pickTimeSubview(_ subview: PickTimeSubView, didSelect time: TimeInterval) {
        
            //store in our singleton / shared resources
            CommutrResources.sharedResources.setTimeForTasks(time: time)
        
            //reload data once we've sorted
            CommutrResources.sharedResources.sortTasks { (success) in
                self.tableView.reloadData()
            }
        
            //BUG: Need to move datepicker otherwise initial minute value is wrong
            //hide picker
            util.setView(view: timeSubview!, hidden: true)
            util.setView(view: timeWindowSubview!, hidden: false)
        
            let time : String = CommutrResources.sharedResources.getTime()
            timeWindowSubview?.setTimeLable(time: time)
    }
    
}

extension FirstViewController : MapViewDelegate {
    func userDidSetMapETA(_ view: MapViewController, time: TimeInterval) {
    
        //store in our singleton / shared resources
        CommutrResources.sharedResources.setTimeForTasks(time: time)
        
        //reload data once we've sorted
        CommutrResources.sharedResources.sortTasks { (success) in
            self.tableView.reloadData()
        }
        
        util.setView(view: timeSubview!, hidden: true)
        util.setView(view: timeWindowSubview!, hidden: false)
        
        if (CommutrResources.sharedResources.useNaturalLanguageTime) {
            let time : String = CommutrResources.sharedResources.getNaturalLanguageTime()
            timeWindowSubview?.setTimeLable(time: time)
        }
    }
}

extension FirstViewController : UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y

        timePickerBottomConstraint.constant = min(offset + minimumConstraint, 0)
        //print(timePickerBottomConstraint.constant)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return -1 * minimumConstraint
        } else {
            //height for each cell
            return 72
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         //got cell
        let idx = indexPath.row - 1
        CommutrResources.sharedResources.removeItem(idx: idx)
        tableView.reloadData()
        
    }
    
}

extension FirstViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") ?? UITableViewCell()
        
        guard indexPath.section != 0 || indexPath.row != 0 else {
            return cell
        }
        
        var idx : Int = (indexPath.row - 1)
        var listems = CommutrResources.sharedResources.getAllItems()
        cell.textLabel?.text = listems[idx].title
        cell.detailTextLabel?.text = "Points: " +  String(Int(listems[idx].storyPoints))
        
        //TODO: Add complete button
        cell.accessoryType = .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommutrResources.sharedResources.getAllItems().count + 1
    }
    
    
}

