//
//  PickTimeSubView.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/30/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit

class PickTimeSubView: UIView {
    
    @IBOutlet weak var PickTimeTitle: UILabel!
    
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
