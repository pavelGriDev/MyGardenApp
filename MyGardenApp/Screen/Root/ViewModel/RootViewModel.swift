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
    
    /// Dependencies
    private let userDefaultService: UserDefaultsService
    private let purchaseService: PurchaseService
    
    init(
        _ userDefaultService: UserDefaultsService = UserDefaultsServiceImp(),
        _ purchaseService: PurchaseService = MockPurchaseServiceImp.shared
    ) {
        self.userDefaultService = userDefaultService
        self.purchaseService = purchaseService
    }
    
    func finisOnboarding() {
        currentScreen = .main
    }
    
    func setup() async {
        await purchaseService.checkStatus()
        await purchaseService.getPaywalls()
        
        await MainActor.run {
            let status = loadOnboardingStatus()
            currentScreen = status ? .main : .onboarding
        }
    }
    
//    func showPaywallTest() {
//        showPaywallScreen = true
//    }
    
    private func loadOnboardingStatus() -> Bool {
        userDefaultService.getFlag(.onboardingCompleted)
    }
    
    private func saveOnboardingStatus() {
        userDefaultService.setFlag(.onboardingCompleted, value: true)
    }
}
