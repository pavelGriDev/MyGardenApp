//
//  MockPurchaseService.swift
//  MyGardenAppTests
//
//  Created by Pavel Gritskov on 06.06.25.
//

import Foundation
@testable import MyGardenApp

class MockPurchaseService: PurchaseService {
    var hasPremium: Bool = false
    var purchase: MyGardenApp.MockPurchaseModel? = nil
    
    func checkStatus() async {
        
    }
    
    func getPaywalls() async {
        purchase = MockPurchaseModel.getPurchaseModel
    }
    
    func makePurchase(_ product: MyGardenApp.MockPurchaseModel.ProductModel) async {
        
    }
    
    func restore() async {
        
    }
}
