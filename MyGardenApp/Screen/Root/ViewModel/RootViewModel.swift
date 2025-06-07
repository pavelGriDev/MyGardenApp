//
//  RootViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

final class RootViewModel: ObservableObject {
    @Published private(set) var currentScreen: StartScreen = .launch
    @Published var isOverlayPaywallVisible = false
    
    /// Dependencies
    private let userDefaultService: UserDefaultsService
    private let purchaseService: PurchaseService
    
    init(
        _ userDefaultService: UserDefaultsService = UserDefaultsServiceImp(),
        _ purchaseService: PurchaseService = MockPurchaseServiceImp.shared,
        _ paywallHandler: PaywallHandler = PaywallCoordinator.shared
    ) {
        self.userDefaultService = userDefaultService
        self.purchaseService = purchaseService
        
        paywallHandler.setPaywallHandler { [weak self] in
            self?.showOverlayPaywall()
        }
    }
    
    func finisOnboardingFromOnboarding() {
        currentScreen = .main
        saveOnboardingStatus()
    }
    
    func finishOnboardingFromPaywall() {
        currentScreen = .main
        saveOnboardingStatus()
    }
    
    func setup() async {
        await purchaseService.checkStatus()
        await purchaseService.getPaywalls()
        
        await MainActor.run {
            let status = loadOnboardingStatus()
            currentScreen = status ? .main : .onboarding
        }
    }
    
    func showOverlayPaywall() {
        guard let _ = purchaseService.purchase else { return }
        DispatchQueue.main.async {
            self.isOverlayPaywallVisible = true
        }
    }
    
    private func loadOnboardingStatus() -> Bool {
        userDefaultService.getFlag(.onboardingCompleted)
    }
    
    private func saveOnboardingStatus() {
        userDefaultService.setFlag(.onboardingCompleted, value: true)
    }
}
