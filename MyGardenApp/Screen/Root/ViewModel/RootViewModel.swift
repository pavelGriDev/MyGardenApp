//
//  RootViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

final class RootViewModel: ObservableObject {
    @Published private(set) var currentScreen: StartScreen = .launch
    @Published var showPaywallScreen = false
    
    func timeDelay() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        await MainActor.run {
            currentScreen = .main
        }
    }
    
    func showPaywallTest() {
        showPaywallScreen = true
    }
}
