//
//  OnboardingView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct OnboardingView: View {

    @StateObject private var vm: OnboardingViewModel
    
    init(_ finishOnboarding: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: OnboardingViewModel(finishOnboarding))
    }
    
    var body: some View {
        TabView(selection: $vm.currentIndex) {
            ForEach(vm.content.indices, id: \.self) { index in
                OnboardingPageView(model: vm.content[index], vm: vm)
            }
            .tabViewDisableSwiping()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .errorAlert(error: $vm.appError)
        .backgroundColor()
        .onDisappear { vm.onDisappear() }
    }
}

#Preview {
    OnboardingView( {} )
}
