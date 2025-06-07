//
//  RootView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI
import NavigationBackport

struct RootView: View {
    
    @StateObject private var vm = RootViewModel()
    @State private var path = NBNavigationPath()
    
    var body: some View {
        NBNavigationStack(path: $path) {
            Group {
                switch vm.currentScreen {
                case .launch:
                    LaunchView()
                case .onboarding:
                    OnboardingView(vm.finisOnboardingFromOnboarding)
                case .main:
                    MainTabBarView()
                }
            }
            .nbNavigationDestination(for: AppRouterModel.self) { screen in
                switch screen {
                case .paywall:
                    OnboardingPaywallView(vm.finishOnboardingFromPaywall)
                }
            }
        }
        .fullScreenCover(isPresented: $vm.isOverlayPaywallVisible, content: {
            OverlayPaywallView()
        })
        .task {
            await vm.setup()
        }
    }
}

#Preview {
    RootView()
}
