//
//  AddViewController.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//
import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var singleton = CommutrResources.sharedResources;
    

    //inputs
    //TODO: Ensure that inputs are number fields
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var storyPoints: UITextField!
    @IBOutlet weak var itemPriority: UITextField!
    
    
    @IBAction func addItemToMainQueue(_ sender: UIButton) {
        if let title = itemTitle?.text, let points = storyPoints?.text, let priority = itemPriority?.text {
            
            if let numPoints = Double(points), let numPriority = Double(priority) {
                //safely unwrapped
                //pass to singleton
                singleton.addItem(title: title, points: numPoints, priority: numPriority)
            }
            else {
                print("Bad input")
            }
        
        } else {
            print("There was some problem unwrapping the optionals ")
        }
        
    }
    
    
}

