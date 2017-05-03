//
//  Utilities.swift
//  Commutr
//
//  Created by Ignacio Streuly on 5/1/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

class Utilities {
    
    //hides or shows view with an animation
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: { _ in
            view.isHidden = hidden
        }, completion: nil)
    }
    
    //Returns a UIColor when given a hex code
    func hexStringToUIColor (hexCode:String) -> UIColor {
        var cString:String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
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
