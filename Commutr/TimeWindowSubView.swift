//
//  TimeWindowSubView.swift
//  Commutr
//
//  Created by Ignacio Streuly on 5/1/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

protocol TimeWindowDelegate: class {
    
    //func pickTimeSubview(_ subview: PickTimeSubView, didSelect time: TimeInterval)
    
}

class TimeWindowSubView: UIView {
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    //    var singleton = CommutrResources.sharedResources;
    
    weak var delegate: TimeWindowDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    
    class func fromNib() -> TimeWindowSubView {
        let nib = UINib(nibName: "TimeWindowSubView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! TimeWindowSubView
        
        return view
    }
    
    func setTimeLable(time: String) {
        timeLeftLabel.text = time
    }
    
}
