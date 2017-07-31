//
//  ViewController.swift
//  MapboxRegionExample
//
//  Created by Erik van der Wal on 31/07/2017.
//  Copyright © 2017 Erik van der Wal. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
    private let centerCoordinate = CLLocationCoordinate2D(latitude: 52.3731, longitude: 4.8932)
    
    private let outerBounds = MGLCoordinateBounds(sw: CLLocationCoordinate2D(latitude: 52.3216, longitude: 4.7685),
                                                  ne: CLLocationCoordinate2D(latitude: 52.4251, longitude: 5.0173))

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let mapView = MGLMapView(frame: view.bounds)
        mapView.delegate = self
        mapView.centerCoordinate = centerCoordinate
        mapView.minimumZoomLevel = 12.0
        mapView.maximumZoomLevel = 20.0
        mapView.zoomLevel = 14.0
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        mapView.compassView.isHidden = true
        mapView.showsUserLocation = true
        
        view.addSubview(mapView)
    }

}

