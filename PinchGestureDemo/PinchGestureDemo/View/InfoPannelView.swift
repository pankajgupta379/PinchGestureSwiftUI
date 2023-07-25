//
//  InfoPannelView.swift
//  PinchGestureDemo
//
//  Created by Pankaj Gupta on 10/06/23.
//

import SwiftUI

struct InfoPannelView: View {
    var scale: Double
    var offSet: CGSize
    
    @State private var isInfoPannelVisible: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    isInfoPannelVisible.toggle()
                }
            
            Spacer()
            
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offSet.width)")
                
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offSet.height)")
            }
            .font(.footnote)
            .padding(8)
            .frame(maxWidth: 420)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .opacity(isInfoPannelVisible ? 1 : 0)
            
            Spacer()
        }
        Spacer()
    }
}

struct InfoPannelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPannelView(scale: 1, offSet: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
