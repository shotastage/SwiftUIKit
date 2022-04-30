//
//  MapPreview.swift
//  Example
//
//  Created by Shota Shimazu on 2022/04/29.
//

import SwiftUI
import MapKit
import SwiftUIKit

struct MapPreview: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.445848, longitude: 139.649769),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )

    @State private var showUserLocation: Bool = true

    @State private var annotationItems = [
        SKAnnotationItem(lat: 35.451777, long: 139.6477825, view: AnyView(
            Circle().foregroundColor(.red).frame(width: 25, height: 25))
        ),
        SKAnnotationItem(lat: 35.442388, long: 139.651349, view: AnyView(
            Circle().foregroundColor(.blue).frame(width: 25, height: 25))
        ),
    ]

    var body: some View {
        SKMapView(region: $region, showsUserLocation: $showUserLocation, userTrackingMode: .follow, annotationItems: annotationItems)
            .edgesIgnoringSafeArea(.all)
    }
}


#if DEBUG
struct MapPreview_Previews: PreviewProvider {
    static var previews: some View {
        MapPreview()
    }
}
#endif
