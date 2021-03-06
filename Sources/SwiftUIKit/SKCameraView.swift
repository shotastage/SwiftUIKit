//
//  SwiftUIView.swift
//  
//
//  Created by Shota Shimazu on 2022/04/11.
//

import AVFoundation

struct SKCameraView: View {
    
    init() {
        print("SWIFˇUIKIT: CameraView is now under construction!")
    }

    var body: some View {
        Text("Hello, Camera View!")
    }
}

#if DEBUG
struct SKCameraView_Previews: PreviewProvider {
    static var previews: some View {
        SKCameraView()
    }
}
#endif
