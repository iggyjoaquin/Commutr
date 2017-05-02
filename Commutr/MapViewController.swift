//
//  MapViewController.swift
//  Commutr
//
//  Created by Ignacio Streuly on 5/1/17.
//  Copyright © 2017 New York University. All rights reserved.
//


import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    //import our utils
    let utils : Utilities = Utilities()
    var sourceSet = false
    var destinationSet = false
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    
    @IBOutlet weak var sourceSearchBar: UISearchBar!
    @IBOutlet weak var destinationSearchBar: UISearchBar!
    
    @IBOutlet weak var mapView: MKMapView!
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        searchResultsTableView.isHidden = true
        mapView.isHidden = false
    }
    
    //invoked when Go is hit
    //gets ETA in seconds and draws route
    @IBAction func getDirections(_ sender: UIButton) {
        let mapDirectionsController = MapDirectionsController()
       
        mapDirectionsController.getETA(addressOne: sourceSearchBar.text!, addressTwo: destinationSearchBar.text!) { (timeInSeconds) in
            
            //timeInSeconds is ETA for inputs
            //Store it in our singleton
            CommutrResources.sharedResources.setTimeForTasks(time: timeInSeconds)
            
            //Get our locations for map render
            mapDirectionsController.addressToCoordinates(address: self.sourceSearchBar.text!, callback: { (locationOne) in
                let firstLocation = locationOne
                
                //get second location
                mapDirectionsController.addressToCoordinates(address: self.destinationSearchBar.text!, callback: { (locationTwo) in
                    let secondLocation = locationTwo
                    
                    //render out route
                    self.renderMapRoute(locationOne: firstLocation, locationTwo: secondLocation)
                })
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        //autocompleter
        searchCompleter.delegate = self
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = utils.hexStringToUIColor(hex: "#81A3FF")
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func renderMapRoute(locationOne: CLLocation, locationTwo: CLLocation) {
        //map route
        mapView.delegate = self
        
        let sourceLocation = CLLocationCoordinate2D(latitude: locationOne.coordinate.latitude, longitude: locationOne.coordinate.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: locationTwo.coordinate.latitude, longitude: locationTwo.coordinate.longitude)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        
        //TODO: Find out what this is doing
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Times Square"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
}

extension MapViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    
        if searchText.characters.count == 0 {
            searchResultsTableView.isHidden = true
            mapView.isHidden = false
            
            if searchBar.placeholder == "Source" {
                sourceSet = false
            } else { //destination
                destinationSet = false
            }
            
        } else {
            mapView.isHidden = true
            searchResultsTableView.isHidden = false
        }
    }
}

extension MapViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        
        //hide/show views
        if searchResults.count > 0 {
            mapView.isHidden = true
        } else {
            searchResultsTableView.isHidden = true
        }
        
        
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension MapViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.accessoryType = .detailDisclosureButton
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension MapViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let clickedAddress : String = searchResults[indexPath.row].title + " " + searchResults[indexPath.row].subtitle
        
        
        //TODO: Fix this logic it's a a hack right now
        if !sourceSet {
            sourceSearchBar.text = clickedAddress
            sourceSet = true
        } else if (!destinationSet) {
            destinationSearchBar.text = clickedAddress
            destinationSet = true
        }
        
        view.endEditing(true)
        searchResultsTableView.isHidden = true
        mapView.isHidden = false
       
    }
}


