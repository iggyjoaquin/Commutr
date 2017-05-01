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

    
    //subviews
    var timeSubview : PickTimeSubView? = nil
    var mapSubview : MapSubView? = nil
    
    //outlets
    @IBOutlet weak var subviewsContainer: UIView!
    
    
    @IBOutlet weak var timePickerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    //actions


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FIXME: find a better way to do this
        //load subviews from nibs
        let loadTimeSubview = PickTimeSubView.fromNib()
        subviewsContainer.addSubview(loadTimeSubview)
        loadTimeSubview.boundInside(subviewsContainer)
        timeSubview = loadTimeSubview
        timeSubview?.delegate = self
        
        let loadMapSubview = MapSubView.fromNib()
        subviewsContainer.addSubview(loadMapSubview)
        loadMapSubview.boundInside(subviewsContainer)
        mapSubview = loadMapSubview
        
    
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var manager = CLLocationManager()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            print("Was not determined")
            manager.requestWhenInUseAuthorization()
        }
        
        minimumConstraint = timePickerBottomConstraint.constant
        
        minimumHeight = tableViewTopConstraint.constant
        tableView.reloadData()
        
        self.view.addSubview(subviewsContainer)
        
        mapSubview?.getETA {  (interval) in
            print(interval)
        }
        
    }
}

extension FirstViewController: PickTimeDelegate {
    

    func pickTimeSubview(_ subview: PickTimeSubView, didSelect time: TimeInterval) {
        
            //TODO: Stuff with shared resources
    }
    
}

extension FirstViewController : UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y

        timePickerBottomConstraint.constant = min(offset + minimumConstraint, 0)
        print(timePickerBottomConstraint.constant)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return -1 * minimumConstraint
        } else {
            return 32
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
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    
    
}

