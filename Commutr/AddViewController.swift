//
//  AddViewController.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//
import UIKit

class AddViewController: UIViewController {
    
    //inputs
    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var storyPoints: UITextField!
    @IBOutlet weak var itemPriority: UITextField!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var addToQueueButton: UIButton!
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //TODO: Changeme
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        formatUserInterface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var singleton = CommutrResources.sharedResources;
    
    @IBAction func addItemToMainQueue(_ sender: UIButton) {
        //TODO: Escape from text screen
        
        if let title = itemTitle?.text, let points = storyPoints?.text, let priority = itemPriority?.text {
            
            if let numPoints = Double(points), let numPriority = Double(priority) {
                //safely unwrapped
                //pass to singleton
                singleton.addItem(title: title, points: numPoints, priority: numPriority)
                
                let alertController = UIAlertController(title: "Task added", message:
                    "We added a task to todays list.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("Bad input")
            }
        
        } else {
            print("There was some problem unwrapping the optionals ")
        }
        
    }
    
    
    func formatUserInterface() {
        let border = CALayer()
        let secondBorder = CALayer()
        let thirdBorder = CALayer()
        let width = CGFloat(1.5)
        
        
        //configure borders
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: itemTitle.frame.size.height - width, width:  itemTitle.frame.size.width, height: itemTitle.frame.size.height)
        border.borderWidth = width
        secondBorder.borderColor = UIColor.lightGray.cgColor
        secondBorder.frame = CGRect(x: 0, y: storyPoints.frame.size.height - width, width:  storyPoints.frame.size.width, height: storyPoints.frame.size.height)
        secondBorder.borderWidth = width
        thirdBorder.borderColor = UIColor.lightGray.cgColor
        thirdBorder.frame = CGRect(x: 0, y: itemPriority.frame.size.height - width, width:  itemPriority.frame.size.width, height: itemPriority.frame.size.height)
        thirdBorder.borderWidth = width
        
        //apply borders
        itemTitle.layer.addSublayer(border)
        itemTitle.layer.masksToBounds = true
        storyPoints.layer.addSublayer(secondBorder)
        storyPoints.layer.masksToBounds = true
        itemPriority.layer.addSublayer(thirdBorder)
        itemPriority.layer.masksToBounds = true
    }
    
}

