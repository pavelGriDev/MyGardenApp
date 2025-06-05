//
//  OnboardingView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct OnboardingView: View {
    @State var currentIndex = 0
    @State var content: [OnboardingPageModel] = OnboardingPageModel.getAll()
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(content.indices, id: \.self) { index in
                OnboardingPageView(model: content[index])
            }
            .tabViewDisableSwiping()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .backgroundColor()
    }
}

#Preview {
    OnboardingView()
}

struct OnboardingPageView: View {
    
    let model: OnboardingPageModel
    
    var body: some View {
        VStack {
            Image(model.backgroundImageName)
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .overlay {
            VStack {
                Spacer()
                
                VStack {
                    Text(model.title)
                    Text(model.bodyText)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
        }
    }
}
