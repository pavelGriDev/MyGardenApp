//
//  PaywallViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

final class OnboardingPaywallViewModel: ObservableObject {
    @Published var freeTrialToggle = false
    @Published var showProgress = false
    @Published var appError: Error?
    private(set) var content: PaywallContentModel = .init(purchaseModel: nil)
    
    private var finishOnboarding: () -> Void
    private var task: Task<(), Never>?
    
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
    
    func setup() {
        guard let paywall = purchaseService.purchase else { return }
        content = .init(purchaseModel: paywall)
        objectWillChange.send()
    }
    
    func onDisappear() {
        task?.cancel()
    }
    
    func continueButtonPressed(_ completion: @escaping () -> Void) {
        guard !showProgress else { return }
        guard let paywall = purchaseService.purchase else { return }
        if freeTrialToggle {
            makePurchase(with: paywall.weekWithTrial, completion)
        } else {
            makePurchase(with: paywall.week, completion)
        }
    }
    
    private func makePurchase(with product: MockPurchaseModel.ProductModel, _ completion: @escaping () -> Void) {
        showProgress = true
        Task {
            await purchaseService.makePurchase(product)
            await MainActor.run {
                if purchaseService.hasPremium {
                    finishOnboarding()
                    completion()
                } else {
                    // ???: возможно вызов алерта с кнопкой "Try Again"
                    self.appError = AppError.failedPurchase
                }
                showProgress = false
            }
        }
    }
    
    func dismissButtonPressed(_ completion: () -> Void) {
        finishOnboarding()
        completion()
    }
    
    func termsButtonPressed(_ completion: (URL) -> Void) {
        guard let url = appInteractionService.termsLink else { return }
        completion(url)
    }
    
    func restoreButtonPressed(_ completion: @escaping () -> Void) {
        guard !showProgress else { return }
        showProgress = true
        task = Task {
            await purchaseService.restore()
            await MainActor.run {
                if purchaseService.hasPremium {
                    finishOnboarding()
                    completion()
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
