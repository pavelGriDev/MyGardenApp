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
    
    private let userDefaultService: UserDefaultsProtocol
    
    init(
        _ userDefaultService: UserDefaultsProtocol = UserDefaultsService()
    ) {
        self.userDefaultService = userDefaultService
    }
    
    func finisOnboarding() {
        print(#function)
        currentScreen = .main
        print("Save state")
    }
    
    func setup() async {
        // timeDelay
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        await MainActor.run {
            let status = loadOnboardingStatus()
            currentScreen = status ? .main : .onboarding
        }
    }
    
    func showPaywallTest() {
        showPaywallScreen = true
    }
    
    private func loadOnboardingStatus() -> Bool {
        userDefaultService.getFlag(.onboardingCompleted)
    }
    
    private func saveOnboardingStatus() {
        userDefaultService.setFlag(.onboardingCompleted, value: true)
    }
}
