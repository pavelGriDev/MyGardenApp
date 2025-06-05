//
//  LaunchView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            Color.appPrimary
                .ignoresSafeArea()
            
            Image(uiImage: .launchScreenPlant)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(y: -11)
            
            Image(uiImage: .launchScreenFrame)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 78)
        }
    }
}

#Preview {
    LaunchView()
}
