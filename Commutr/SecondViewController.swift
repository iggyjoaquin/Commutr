//
//  SecondViewController.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var singleton = CommutrResources.sharedResources;
    
    @IBOutlet weak var includeMapViewSetting: UISwitch!
    @IBOutlet weak var filterTasksSetting: UISwitch!

    @IBOutlet weak var labelOneMap: UILabel!
    @IBOutlet weak var labelTwoMap: UILabel!
    @IBOutlet weak var labelThreeMap: UILabel!
    @IBOutlet weak var labelFourMap: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        formatUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatUI() {
        labelOneMap.clipsToBounds = true
        labelOneMap.layer.cornerRadius = labelOneMap.frame.width/2
        labelTwoMap.clipsToBounds = true
        labelTwoMap.layer.cornerRadius = labelOneMap.frame.width/2
        labelThreeMap.clipsToBounds = true
        labelThreeMap.layer.cornerRadius = labelOneMap.frame.width/2
        labelFourMap.clipsToBounds = true
        labelFourMap.layer.cornerRadius = labelOneMap.frame.width/2
    }


}

