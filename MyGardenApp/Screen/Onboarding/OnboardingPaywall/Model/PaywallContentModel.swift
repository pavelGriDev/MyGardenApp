//
//  PaywallContentModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

struct PaywallContentModel {
    private let purchaseModel: MockPurchaseModel?
    
    init(purchaseModel: MockPurchaseModel?) {
        self.purchaseModel = purchaseModel
    }
    
    let title = "Identification without restrictions"
    let buttonTitle = "Continue"
    let toggleTitle = "Enable a 3-day free trial"
    
    var weekLocalizedPrice: String {
        guard let pw = purchaseModel else { return "_" }
        return "\(pw.week.currencySymbol)\(pw.week.price)"
    }
    
    var bodyText: String {
        "Subscribe to unlock all the features, \njust for \(weekLocalizedPrice)/week"
    }
    
    var bodyTextIfTrial: String {
        bodyText + " + 3-day free trial"
    }
}
