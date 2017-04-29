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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print(singleton.getProps())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

