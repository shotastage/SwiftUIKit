//
//  SKWebView.swift
//  SwiftUIKit
//
//  Created by Shota Shimazu on 2022/04/05.
//

import SwiftUI
#if !os(tvOS) || !os(watchOS)
import WebKit

public struct SKWebView: UIViewRepresentable {
    let url: String

    public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {

        var parent: SKWebView

        init(_ parent: SKWebView) {
            self.parent = parent
        }

        public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: URL(string: url)!)

        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.load(request)
    }
}
#else

public struct SKWebView: View {
    let url: String
    
    public var body: some View {
        Text("Can not preview \(url) on tvOS or watchOS.")
    }
}

#endif


#if DEBUG
struct SKWebView_Previews: PreviewProvider {
    static var previews: some View {
        SKWebView(url: "http://apple.com")
    }
}
#endif
