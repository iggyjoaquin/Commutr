//
//  PickTimeSubView.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/30/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

protocol PickTimeDelegate: class {
    
    func pickTimeSubview(_ subview: PickTimeSubView, didSelect time: TimeInterval)
    
}

class PickTimeSubView: UIView {
    
//    var singleton = CommutrResources.sharedResources;
    
    weak var delegate: PickTimeDelegate?
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func submitTime(_ sender: UIButton) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: timePicker.date)
        
        var calendar = Calendar.current
        var timeInSeconds: TimeInterval = 0
        timeInSeconds += 3600 * Double(calendar.component(.hour, from: timePicker.date))
        timeInSeconds += 60 * Double(calendar.component(.minute, from: timePicker.date))
    
        delegate?.pickTimeSubview(self, didSelect: timeInSeconds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    class func fromNib() -> PickTimeSubView {
        let nib = UINib(nibName: "PickTimeSubView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! PickTimeSubView
        
        return view
    }
    
    
    

}
