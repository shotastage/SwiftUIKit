//
//  SKMapView.swift
//
//
//  Created by Shota Shimazu on 2022/03/29.
//

import SwiftUI
import MapKit

#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif


public struct SKMapView: View {
    // 35.458911, 139.631277

    var region: Binding<MKCoordinateRegion>
    
    var showsUserLocation: Binding<Bool>

    public init(region: Binding<MKCoordinateRegion>, showsUserLocation: Binding<Bool>) {
        self.region = region
        self.showsUserLocation = showsUserLocation
    }

    public var body: some View {
        if #available(iOS 14.0, *) {
            Map(coordinateRegion: region)
        } else {
            UIKitMapView(coordinateRegion: region, showsUserLocation: showsUserLocation)
        }
    }
}

private struct UIKitMapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    @Binding var coordinateRegion: MKCoordinateRegion

    @Binding var showsUserLocation: Bool

    
    let map = MKMapView()

    func makeUIView(context: Context) -> MKMapView {
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

        uiView.mapType = .satellite
        uiView.showsUserLocation = showsUserLocation
        uiView.setRegion(coordinateRegion, animated: true)
    }
}

#if DEBUG
struct MapKitView_Previews: PreviewProvider {
    
     @State static var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.458911, longitude: 139.631277),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

    @State static var showUserLocarion = true
    static var previews: some View {
        SKMapView(region: $region, showsUserLocation: $showUserLocarion)
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
