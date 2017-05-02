//
//  TimeWindowSubView.swift
//  Commutr
//
//  Created by Ignacio Streuly on 5/1/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

protocol TimeWindowDelegate: class {
  
    
    func timeWindowSubviewDidTapReset(_ subview: TimeWindowSubView)
    
}

class TimeWindowSubView: UIView {
    var util = Utilities()
    
    //outlets
    @IBOutlet weak var timeLeftLabel: UILabel!
    weak var delegate: TimeWindowDelegate?
    
    @IBAction func resetTimeButton(_ sender: UIButton) {
        delegate?.timeWindowSubviewDidTapReset(self)
    }
    
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
