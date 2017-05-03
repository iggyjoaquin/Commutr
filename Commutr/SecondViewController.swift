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
    @IBOutlet weak var storyPointsMultipleLabel: UITextField!
    
    @IBOutlet weak var showNaturalLanguageClockSetting: UISwitch!
    @IBOutlet weak var filterListSetting: UISwitch!
    
    @IBAction func updatePreferences(_ sender: UIButton) {
        //update our settings
        CommutrResources.sharedResources.updateSettings(naturalLanguageClock: showNaturalLanguageClockSetting.isOn, filterList: filterListSetting.isOn, pointsScalar: Int(storyPointsMultipleLabel.text!)!)
        
    
        // after we update singleton
        let alertController = UIAlertController(title: "Updated", message:
            "Your preferences were updated!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        formatUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatUI() {
        storyPointsMultipleLabel?.text! = String(CommutrResources.sharedResources.pointsScalar)
    }


}

