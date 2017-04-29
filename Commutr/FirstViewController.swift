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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().backgroundColor = hexStringToUIColor(hex: "#434343")
        print(singleton.getProps())
    
    }
    
    
    @IBAction func printNameButton(_ sender: UIButton) {
        print(singleton.getProps())
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
    
    //unused
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

