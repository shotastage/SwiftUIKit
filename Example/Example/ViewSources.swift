//
//  ViewSources.swift
//  Example
//
//  Created by Shota Shimazu on 2022/04/17.
//

import SwiftUI
import SwiftUIKit
import MapKit

enum ViewDataSource: CaseIterable {

    case map
    case web
    case blank
    case picker

    @ViewBuilder
    var screen: some View {
        switch self {
        case .map: MapPreview().ignoresSafeArea()
        case .web: SKWebView(url: "https://apple.com").ignoresSafeArea()
        case .blank: SKBlankView()
        case .picker: PickerExampleView()
        }
    }
    
    var name: String {
        switch self {
        case .map: return "🗺 Map View"
        case .web: return "🌏 Web View"
        case .blank: return "⬛️ Blank View"
        case .picker: return "⛏ Example Picker"

        }
    }
}


struct MapPreview: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020),
        latitudinalMeters: 750,
        longitudinalMeters: 750
    )
        
    @State private var showUserLocation: Bool = true

    var body: some View {
        SKMapView(region: $region, showsUserLocation: $showUserLocation)
    }
}

struct PickerExampleView: View {
    
    private var viewSources = ViewDataSource.allCases
    
    @State private var selection = 3

    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("Select View")) {
                ForEach(0 ..< viewSources.count) { idx in
                    Text(self.viewSources[idx].name)
                }
            }
            .frame(width: 400)
                    
            Text("Selection：\(viewSources[selection].name)")
        }
    }
}
