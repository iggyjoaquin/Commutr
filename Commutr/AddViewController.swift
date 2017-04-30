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
    
    struct ListItem {
        var title: String
        var storyPoints: Double
        var priority: Double
        
        init(title: String, storyPoints: Double, priority: Double) {
            self.title = title
            self.storyPoints = storyPoints
            self.priority = priority
            print("init'd")
        }
        
        
    }

    //inputs
    //TODO: Ensure that inputs are number fields
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var storyPoints: UITextField!
    @IBOutlet weak var itemPriority: UITextField!
    
    
    @IBAction func addItemToMainQueue(_ sender: UIButton) {
        if let title = itemTitle?.text, let points = storyPoints?.text, let priority = itemPriority?.text {
            //safely unwrapped
            //lets make a struct that represents the item
            
            var newItem = ListItem(title: title, storyPoints: Double(points)!, priority: Double(priority)!)
            
            //TODO: Pass to singleton
            
            
        } else {
            print("There was some problem")
        }
        
    }
    
    
}

