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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //manually add items to test
        CommutrResources.sharedResources.addItem(title: "Test", points: 2.0, priority:10.0)
        CommutrResources.sharedResources.addItem(title: "Test", points: 2.0, priority:10.0)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //var manager = CLLocationManager()
        
        //if CLLocationManager.authorizationStatus() == .notDetermined {
        //    print("Was not determined")
        //    manager.requestWhenInUseAuthorization()
        //}
     
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


extension FirstViewController: PickTimeDelegate {
    
    func pickTimeSubview(_ subview: PickTimeSubView, didSelect time: TimeInterval) {
        
            //store in our singleton / shared resources
            CommutrResources.sharedResources.setTimeForTasks(time: time)
        
            print(time)
            //hide picker
//            util.setView(view: timeSubview!, hidden: true)
//            util.setView(view: timeWindowSubview!, hidden: false)
        
            if (CommutrResources.sharedResources.useNaturalLanguageTime) {
                let time : String = CommutrResources.sharedResources.getNaturalLanguageTime()
                timeWindowSubview?.setTimeLable(time: " Heyyyyyy")
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
        cell.detailTextLabel?.text = "Priority: " +  String(listems[idx].priority)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommutrResources.sharedResources.getAllItems().count + 1
    }
    
    
}

