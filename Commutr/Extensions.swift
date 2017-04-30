//
//  Extensions.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/30/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

extension UIView {
    public func boundInside(_ superView: UIView, top: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0, right: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(left)-[subview]-\(right)-|", options: NSLayoutFormatOptions(), metrics:nil, views:["subview":self]))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(top)-[subview]-\(bottom)-|", options: NSLayoutFormatOptions(), metrics:nil, views:["subview":self]))
    }
}   
