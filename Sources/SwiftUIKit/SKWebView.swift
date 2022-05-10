//
//  SKWebView.swift
//  SwiftUIKit
//
//  Created by Shota Shimazu on 2022/04/05.
//

import SwiftUI
import UIKit
#if !os(tvOS) || !os(watchOS)
import WebKit


public enum SKWebLoadingMode {
    case none
    case indicator
    case progress
    case custom
}

public struct SKWebView: UIViewRepresentable {

    public var url: String

    public var userAgent: String?

    public var backgroundColor: UIColor?

    var loadingMode: SKWebLoadingMode

    var webView = WKWebView()

    var progressView: UIProgressView?

    var indicatorView: UIActivityIndicatorView?

    public init(url: String, loadingMode: SKWebLoadingMode = .none) {
        self.url = url
        self.loadingMode = loadingMode
        
        switch loadingMode {
        case .none:
            break
        case .indicator:
            indicatorView = UIActivityIndicatorView()
        case .progress:
            progressView = UIProgressView()
        case .custom:
            print("Now under construction...")
        }
    }

    public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {

        var parent: SKWebView

        init(_ parent: SKWebView) {
            self.parent = parent
        }

        func addProgressObserver() {
            parent.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        }

        public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

            if keyPath == "estimatedProgress" {
                parent.progressView?.alpha = 1.0
                parent.progressView?.setProgress(Float(parent.webView.estimatedProgress), animated: true)
                if parent.webView.estimatedProgress >= 1.0 {
                    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: { [weak self] in
                        self?.parent.progressView?.alpha = 0.0
                    }, completion: { (finished: Bool) in
                        self.parent.progressView?.setProgress(0.0, animated: false)
                    })
                }
            }
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

        switch loadingMode {
        case .none:
            break
        case .indicator:
            webView.addSubview(indicatorView!)
            setupIndicator()
        case .progress:
            webView.addSubview(progressView!)
            setupProgressBar()
        case .custom:
            break
        }

        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.addProgressObserver()

        let request = URLRequest(url: URL(string: url)!)

        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.load(request)
    }

    private func setupProgressBar() {
        progressView?.translatesAutoresizingMaskIntoConstraints = false
        progressView?.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 1.0).isActive = true
        progressView?.topAnchor.constraint(equalTo: webView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        progressView?.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 0).isActive = true
    }

    private func setupIndicator() {
        //
    }
}


extension SKWebView {
    public func background(_ color: Color) -> SKWebView {
        let view = self
        view.webView.backgroundColor = SKColor(color).uiColor
        return view
    }

    public func userAgent(_ ua: String) -> SKWebView {
        let view = self
        view.webView.customUserAgent = ua
        return view
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
        SKWebView(url: "http://apple.com", loadingMode: .progress)
            .background(.blue)
    }
}
#endif
