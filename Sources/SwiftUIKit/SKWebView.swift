//
//  SKWebView.swift
//  SwiftUIKit
//
//  Created by Shota Shimazu on 2022/04/05.
//

import SwiftUI
import WebKit

struct SKWebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
            
            uiView.load(URLRequest(url: URL(string: url)!))
        }
}

struct SKWebView_Previews: PreviewProvider {
    static var previews: some View {
        SKWebView(url: "http://apple.com")
    }
}
