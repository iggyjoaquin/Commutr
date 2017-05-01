//
//  MapDirectionsController.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/30/17.
//  Copyright © 2017 New York University. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapDirectionsController {
    func getDirections(address: String, callback: @escaping (MKDirections) -> Void) {
        let directionsRequestObject = MKDirectionsRequest()
        
        //directionsRequestObject.source = MKMapItem.forCurrentLocation()
        
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard error == nil else {
                print(error)
                return
            }
            
            geocoder.geocodeAddressString("33 65th Street, NJ, USA", completionHandler: { (placemarksSecondAddrress, errorSecondAddress) in
                guard error == nil else {
                    print(errorSecondAddress)
                    return
                }
                
                if let placemark = placemarks?[0] as? CLPlacemark, let secondPlacemark = placemarksSecondAddrress?[0] as? CLPlacemark {
                    
                    let newPlacemark = MKPlacemark(placemark: placemark)
                    let mapItem = MKMapItem(placemark: newPlacemark)
                    
                    
                    //second address
                    let secondNewPlacemark = MKPlacemark(placemark: secondPlacemark)
                    let secondMapItem = MKMapItem(placemark: secondNewPlacemark)

                    
                    directionsRequestObject.source = secondMapItem
                    directionsRequestObject.destination = mapItem
                    
                    directionsRequestObject.departureDate = Date()
                    directionsRequestObject.transportType = .automobile
                    
                    let directions = MKDirections(request: directionsRequestObject)
                    
                    callback(directions)
                    
                }
            })
            
        }
        
    }
    
    func getETA(address: String, callback: @escaping (TimeInterval) -> Void) {
        getDirections(address: address) { (directions) in
            
        
            let eta = directions.calculateETA(completionHandler: { (response, error) in
                guard error == nil, let response = response else {
                    print(error)
                    return
                }
                
                //code goes here
                callback((response.expectedTravelTime))
                
            })
        }
    }
    

}
