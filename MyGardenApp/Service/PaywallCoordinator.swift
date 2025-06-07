//
//  PaywallService.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

protocol PaywallTrigger {
    func showPaywall()
}

protocol PaywallHandler {
    func setPaywallHandler(_ handler: @escaping () -> Void)
}

final class PaywallCoordinator: PaywallTrigger, PaywallHandler {
    static let shared = PaywallCoordinator()
    
    private var paywallHandler: (() -> Void)?
    
    private init() {}
    
    func setPaywallHandler(_ handler: @escaping () -> Void) {
        paywallHandler = handler
    }
    
    func showPaywall() {
        paywallHandler?()
    }
}
