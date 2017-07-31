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
        mapView.minimumZoomLevel = 8.0
        mapView.maximumZoomLevel = 20.0
        mapView.zoomLevel = 12.0
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mapView.isPitchEnabled = false
        mapView.isRotateEnabled = false
        mapView.compassView.isHidden = true
        mapView.showsUserLocation = true
        
        view.addSubview(mapView)
    }
    
    // MARK: - MGLMapViewDelegate
    
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        var adjusted = mapView.visibleCoordinateBounds
        
        if mapView.visibleCoordinateBounds.ne.latitude > outerBounds.ne.latitude {
            let diff = mapView.visibleCoordinateBounds.ne.latitude - outerBounds.ne.latitude
            adjusted.ne.latitude = outerBounds.ne.latitude
            adjusted.sw.latitude = fmax(mapView.visibleCoordinateBounds.sw.latitude - diff, outerBounds.sw.latitude)
        }
        
        if mapView.visibleCoordinateBounds.sw.latitude < outerBounds.sw.latitude {
            let diff = outerBounds.sw.latitude - mapView.visibleCoordinateBounds.sw.latitude
            adjusted.sw.latitude = outerBounds.sw.latitude
            adjusted.ne.latitude = fmin(mapView.visibleCoordinateBounds.ne.latitude + diff, outerBounds.ne.latitude)
        }
        
        if mapView.visibleCoordinateBounds.sw.longitude < outerBounds.sw.longitude {
            let diff = outerBounds.sw.longitude - mapView.visibleCoordinateBounds.sw.longitude
            adjusted.sw.longitude = outerBounds.sw.longitude
            adjusted.ne.longitude = fmin(mapView.visibleCoordinateBounds.ne.longitude + diff, outerBounds.ne.longitude)
        }

        if mapView.visibleCoordinateBounds.ne.longitude > outerBounds.ne.longitude {
            let diff = mapView.visibleCoordinateBounds.ne.longitude - outerBounds.ne.longitude;
            adjusted.ne.longitude = outerBounds.ne.longitude
            adjusted.sw.longitude = fmax(mapView.visibleCoordinateBounds.sw.longitude - diff, outerBounds.sw.longitude)
        }
        
        if !MGLCoordinateBoundsEqualToCoordinateBounds(mapView.visibleCoordinateBounds, adjusted) {
            mapView.setVisibleCoordinateBounds(adjusted, animated: false)
        }
    }

}

