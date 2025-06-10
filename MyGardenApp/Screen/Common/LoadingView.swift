//
//  LoadingView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import SwiftUI

struct LoadingView: View {
    
    private let gifName = "plantsProgress"
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                    .frame(height: proxy.size.height * 0.15)
                
                GifView(gifName)
                    .frame(height: 355)
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .backgroundColor()
    }
}
