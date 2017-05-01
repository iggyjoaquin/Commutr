//
//  MapSubView.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/30/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import UIKit
import MapKit

protocol MapSubViewDelegate: class {
    
//    func pickTimeSubview(_ subview: PickTimeSubView, didSelect time: TimeInterval)
    
}

class MapSubView: UIView {
    
    //    var singleton = CommutrResources.sharedResources;
    
    weak var delegate: MapSubViewDelegate?
    var directionsController = MapDirectionsController()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)!
        

    }
    
    class func fromNib() -> MapSubView {
        let nib = UINib(nibName: "MapSubView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! MapSubView
        
        return view
    }
    
    func getETA(callback:  @escaping (TimeInterval) -> Void ) {
        directionsController.getETA(address: "690 Washington Street, NY, USA") { (returnInterval) in
            //timeInterval is just a double in seconds
            print(returnInterval)
            callback(returnInterval)
        }
    }
    
    
}
