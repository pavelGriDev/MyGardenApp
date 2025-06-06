//
//  PurchaseModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import Foundation

struct MockPurchaseModel {
    let week: ProductModel
    let oneTime: ProductModel
    
    struct ProductModel {
        let price: String
        let currencySymbol: String
    }
    
    static let getPurchaseModel = MockPurchaseModel(
        week: .init(price: "4.99", currencySymbol: "$"),
        oneTime: .init(price: "119.99", currencySymbol: "$")
    )
}
