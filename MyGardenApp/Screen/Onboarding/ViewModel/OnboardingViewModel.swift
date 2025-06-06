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
    @Published var showProgress = false
    @Published var appError: Error?
    
    private var finishOnboarding: () -> Void
    private var task: Task<(), Never>?
    private var didRequestAppRating = false

    /// Dependencies
    private let purchaseService: PurchaseService
    private let appInteractionService: AppInteractionService
     
    init(
        _ finishOnboarding: @escaping () -> Void,
        _ purchaseService: PurchaseService = MockPurchaseServiceImp.shared,
        _ appInteractionService: AppInteractionService = AppInteractionServiceImp()
    ) {
        self.finishOnboarding = finishOnboarding
        self.purchaseService = purchaseService
        self.appInteractionService = appInteractionService
    }
    
    func onDisappear() {
        task?.cancel()
    }
    
    func continueButtonPressed(_ completion: () -> Void) {
        guard !showProgress else { return }
        switch (currentIndex + 1 < content.count, purchaseService.purchase == nil) {
        case (true, _):
            currentIndex += 1
        case (false, true):
            finishOnboarding()
        case (false, false):
            completion()
        }
        shouldRequestReview()
    }
    
    private func shouldRequestReview() {
        guard self.currentIndex == content.count - 1 && !didRequestAppRating else { return }
        appInteractionService.requestAppReview()
        didRequestAppRating = true
    }
    
    func termsButtonPressed(_ completion: (URL) -> Void) {
        guard let url = appInteractionService.termsLink else { return }
        completion(url)
    }
    
    func restoreButtonPressed() {
        guard !showProgress else { return }
        showProgress = true
        task = Task {
            await purchaseService.restore()
            await MainActor.run {
                if purchaseService.hasPremium {
                    finishOnboarding()
                } else {
                    self.appError = AppError.failedRestore
                }
                showProgress = false
            }
        }
    }
    
    func privacyButtonPressed(_ completion: (URL) -> Void) {
        guard let url = appInteractionService.privacyLink else { return }
        completion(url)
    }
}
