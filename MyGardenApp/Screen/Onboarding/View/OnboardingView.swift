//
//  OnboardingView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct OnboardingView: View {

    @StateObject private var vm = OnboardingViewModel()
    
    var body: some View {
        TabView(selection: $vm.currentIndex) {
            ForEach(vm.content.indices, id: \.self) { index in
                OnboardingPageView(model: vm.content[index], vm: vm)
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
