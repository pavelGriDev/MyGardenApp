//
//  OverlayPaywallViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

final class OverlayPaywallViewModel: ObservableObject {
    @Published var showProgress = false
    @Published var appError: Error?
    private(set) var content: OverlayPaywallContentModel = .init(purchaseModel: nil)
    
    private var task: Task<(), Never>?
    
    /// Dependencies
    private let purchaseService: PurchaseService
    private let appInteractionService: AppInteractionService
     
    init(
        _ purchaseService: PurchaseService = MockPurchaseServiceImp.shared,
        _ appInteractionService: AppInteractionService = AppInteractionServiceImp()
    ) {
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
    
    func dismissButtonPressed(_ completion: () -> Void) {
        completion()
    }
    
    func continueButtonPressed(_ completion: @escaping () -> Void) {
        guard !showProgress else { return }
        guard let paywall = purchaseService.purchase else { return }
        makePurchase(with: paywall.oneTime, completion)
    }
    
    private func makePurchase(with product: MockPurchaseModel.ProductModel, _ completion: @escaping () -> Void) {
        showProgress = true
        Task {
            await purchaseService.makePurchase(product)
            await MainActor.run {
                if purchaseService.hasPremium {
                    completion()
                } else {
                    // ???: возможно вызов алерта с кнопкой "Try Again"
                    self.appError = AppError.failedPurchase
                }
                showProgress = false
            }
        }
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
