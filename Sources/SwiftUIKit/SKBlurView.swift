//
//  SwiftUIView.swift
//
//
//  Created by Shota Shimazu on 2022/05/12.
//

import UIKit


public struct SKBlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    let view = UIView(frame: .zero)

    public init(style: UIBlurEffect.Style) {
        self.style = style
    }

    public func makeUIView(context: UIViewRepresentableContext<SKBlurView>) -> UIView {
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)

        blurView.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = .clear
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])

        return view
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<SKBlurView>) { }
}


#if DEBUG
struct SKBlurView_Previews: PreviewProvider {
    static var previews: some View {
        SKBlurView(style: .light)
            .background(Color.blue)
    }
}
#endif

