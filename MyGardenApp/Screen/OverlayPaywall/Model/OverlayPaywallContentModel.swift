//
//  OverlayPaywallContentModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

struct OverlayPaywallContentModel {
    private let purchaseModel: MockPurchaseModel?
    
    init(purchaseModel: MockPurchaseModel?) {
        self.purchaseModel = purchaseModel
    }
    
    let title = "Identification without restrictions"
    let buttonTitle = "Continue"
    
    var oneTimeLocalizedPrice: String {
        guard let pw = purchaseModel else { return "_" }
        return "\(pw.oneTime.currencySymbol)\(pw.oneTime.price)"
    }
    
    var bodyText: String {
        "Subscribe to unlock all the features, \njust for \(oneTimeLocalizedPrice) at one time"
    }
}
