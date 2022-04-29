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


public enum SKMapUserTrackingModes: Hashable {
    case none
    case follow

    @available(iOS 14.0, *)
    var nativeMapUserTrackingMode: MapUserTrackingMode {
        switch self {
        case .none: return MapUserTrackingMode.none
        case .follow: return MapUserTrackingMode.follow
        }
    }
}

public enum SKMapInteractionModes: Hashable {
    case all
    case pan
    case zoom

    @available(iOS 14.0, *)
    var nativeMapUserTrackingMode: MapInteractionModes {
        switch self {
        case .all: return MapInteractionModes.all
        case .pan: return MapInteractionModes.pan
        case .zoom: return MapInteractionModes.zoom
        }
    }
}

public enum SKMapUserTrackingMode: Hashable {
    case follow
    case none

    @available(iOS 14.0, *)
    var nativeMapUserTrackingMode: MapUserTrackingMode {
        switch self {
        case .follow: return MapUserTrackingMode.follow
        case .none: return MapUserTrackingMode.none
        }
    }
}

public struct SKAnnotationItem<ElementView: View>: Identifiable {
    public let id: UUID
    let location: CLLocationCoordinate2D
    let view: ElementView

    public init(id: UUID = UUID(), lat: Double, long: Double, view: ElementView) {
        self.id = id
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.view = view
    }
}


public struct SKMapView: View {

    var region: Binding<MKCoordinateRegion>

    var showsUserLocation: Binding<Bool>

    var annotations: [SKAnnotationItem<AnyView>]?

    var interactionModes: SKMapInteractionModes

    // Initializer for no-annotation map
    public init(
        region: Binding<MKCoordinateRegion>,
        showsUserLocation: Binding<Bool>,
        interactionModes: SKMapInteractionModes = .all,
        userTrackingMode: SKMapUserTrackingMode = .none) {
        self.region = region
        self.showsUserLocation = showsUserLocation
        self.interactionModes = interactionModes
    }

    // Initializer with annotations map
    public init(
        region: Binding<MKCoordinateRegion>,
        showsUserLocation: Binding<Bool>,
        interactionModes: SKMapInteractionModes = .all,
        userTrackingMode: SKMapUserTrackingMode = .none,
        annotationItems: [SKAnnotationItem<AnyView>]?) {
        self.region = region
        self.showsUserLocation = showsUserLocation
        self.interactionModes = interactionModes
        self.annotations = annotationItems
    }

    public var body: some View {
        if #available(iOS 14.0, *) {
            Map(coordinateRegion: region,
            interactionModes: .all,
            showsUserLocation: showsUserLocation.wrappedValue,
            annotationItems: annotations ?? []) { place in
                MapAnnotation(coordinate: place.location) {
                    place.view
                }
            }
        } else {
            UIKitMapView(coordinateRegion: region, showsUserLocation: showsUserLocation)
        }
    }
}


// Custom Map View for ~< iOS13
private struct UIKitAnnotationItem<ElementView: UIView> {
    let title: String
    let coordinate: CLLocationCoordinate2D
    let view: ElementView

    init(title: String = UUID().uuidString, coordinate: CLLocationCoordinate2D, view: ElementView) {
        self.title = title
        self.coordinate = coordinate
        self.view = view
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

        let childView = UIHostingController(rootView: AnyView(Text("HELLO")))
        uiView.addSubview(childView.view)
    }

    func convertAnnotation() {

    }
}


#if DEBUG
struct MapKitView_Previews: PreviewProvider {

    @State static var annotationItems = [
        SKAnnotationItem(lat: 35.453189, long: 139.638021, view: AnyView(
            Circle().foregroundColor(.red).frame(width: 25, height: 25))
        ),
        SKAnnotationItem(lat: 35.451780, long: 139.636005, view: AnyView(
            Circle().foregroundColor(.blue).frame(width: 25, height: 25))
        ),
    ]

    @State static var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 35.458911, longitude: 139.631277),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

    @State static var showUserLocation = true

    static var previews: some View {
        SKMapView(region: $region, showsUserLocation: $showUserLocation, userTrackingMode: .follow, annotationItems: annotationItems)
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
