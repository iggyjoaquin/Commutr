//
//  FirstViewController.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var singleton = CommutrResources.sharedResources;
    var test : PickTimeSubView? = nil
    
    @IBOutlet weak var timePickerContainer: PickTimeSubView!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func submitTime(_ sender: UIButton) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: timePicker.date)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let view = PickTimeSubView.fromNib()
        timePickerContainer.addSubview(view)
        view.boundInside(timePickerContainer)
        test = view;
      
        //UITabBar.appearance().tintColor = UIColor.black
        //UITabBar.appearance().backgroundColor = hexStringToUIColor(hex: "#434343")
        
    
    }
    

    @IBAction func testAnimate(_ sender: UIButton) {
        
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { _ in
            self.test?.isHidden = !(self.test?.isHidden)!
        }, completion: nil)
    }
    
    
    
    //helper function for hex colors
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
}

extension UIView {
    public func boundInside(_ superView: UIView, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(left)-[subview]-\(right)-|", options: NSLayoutFormatOptions(), metrics:nil, views:["subview":self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(top)-[subview]-\(bottom)-|", options: NSLayoutFormatOptions(), metrics:nil, views:["subview":self]))
    }
}

