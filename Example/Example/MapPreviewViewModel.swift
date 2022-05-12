//
//  MapPreviewViewModel.swift
//  Example
//
//  Created by Shota Shimazu on 2022/04/30.
//

import MapKit
import SwiftUIKit


final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 35.446678814124645,
            longitude: 139.64264368414757
        ),
        latitudinalMeters: 1800.0,
        longitudinalMeters: 1800.0
    )

    @Published var tracking: SKMapUserTrackingModes = .follow

    override init() {
        super.init()
        manager.delegate = self
    }
}


final class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared: LocationManager = LocationManager()

    static let defaultLocation = CLLocationCoordinate2D(latitude: 35.6946632881852, longitude: 139.74921390903137)

    static var currentLocation: CLLocationCoordinate2D {
        guard let location = shared.locationManager.location else {
            return defaultLocation
        }

        return location.coordinate
    }

    private let locationManager = CLLocationManager()

    private override init() {
        super.init()
        initializeManager()
    }

    private func initializeManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
}
