//
//  SwiftUIView.swift
//  
//
//  Created by Shota Shimazu on 2022/05/12.
//

import SwiftUI

public struct SKVisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    public func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = effect
    }
}


#if DEBUG
struct SKVisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        SKVisualEffectView()
    }
}
#endif
