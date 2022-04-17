//
//  ContentView.swift
//  Example
//
//  Created by Shota Shimazu on 2022/04/09.
//

import SwiftUI
import SwiftUIKit
import MapKit

struct ContentView: View {

    @State private var isActive: Bool = true
    
    @State private var centerRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 139.63104, longitude: 35.46124), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

    @State private var showUserLocation = true

    private let views = ["🗺 Map View", "🌏 Web View", "⬛️ Blank View"]

    var body: some View {
        NavigationView {
            List(views, id: \.self) { view in
                NavigationLink(destination: Text("\(view)番目のView")) {
                            Text(view)
                        }
            }
            .navigationTitle("SwiftUIKit Views")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
