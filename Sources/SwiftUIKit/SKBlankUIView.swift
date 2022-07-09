//
//  SKBlankView.swift
//  
//
//  Created by Shota Shimazu on 2022/04/16.
//

#if DEBUG
public struct SKBlankView: View {
    
    public init() {}
    
    public var body: some View {
        Text("__BLANK__")
    }
}

struct SKBlankView_Previews: PreviewProvider {
    static var previews: some View {
        SKBlankView()
    }
}
#endif
