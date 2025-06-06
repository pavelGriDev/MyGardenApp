//
//  OnboardingViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

final  class OnboardingViewModel: ObservableObject {
    @Published var currentIndex = 0
    private(set) var content: [OnboardingPageModel] = OnboardingPageModel.getAll()
    
    private var finishOnboarding: () -> Void
    
    /// Dependencies
    private let purchaseService: PurchaseService
     
    init(
        _ finishOnboarding: @escaping () -> Void,
        _ purchaseService: PurchaseService = MockPurchaseServiceImp.shared
    ) {
        self.finishOnboarding = finishOnboarding
        self.purchaseService = purchaseService
    }
    
    func continueButtonPressed(_ completion: () -> Void) {
        switch (currentIndex + 1 < content.count, purchaseService.purchase == nil) {
        case (true, _):
            currentIndex += 1
        case (false, true):
            finishOnboarding()
        case (false, false):
            completion()
        }
    }
    
    func termsButtonPressed() {
        print(#function)
    }
    
    func restoreButtonPressed() {
        print(#function)
    }
    
    func privacyButtonPressed() {
        print(#function)
    }
}
