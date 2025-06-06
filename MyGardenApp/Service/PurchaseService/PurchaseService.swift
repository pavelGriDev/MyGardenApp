//
//  PurchaseService.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import Foundation

protocol PurchaseService {
    var hasPremium: Bool { get }
    var purchase: MockPurchaseModel? { get }
    func checkStatus() async
    func getPaywalls() async
    func makePurchase(_ product: MockPurchaseModel.ProductModel) async
    func restore() async
}

final class MockPurchaseServiceImp: PurchaseService {
    
    static let shared = MockPurchaseServiceImp()
    
    private(set) var hasPremium: Bool = false
    private(set) var purchase: MockPurchaseModel?
    
    // for test
    private var premiumStatusAfterCheck = false
    private var premiumStatusAfterRestore = false
    
    func checkStatus() async {
        await delay()
        hasPremium = premiumStatusAfterCheck ? true : false
    }
    
    func getPaywalls() async {
        await delay()
        purchase = MockPurchaseModel.getPurchaseModel
    }
    
    func makePurchase(_ product: MockPurchaseModel.ProductModel) async {
        await delay()
        hasPremium = true
    }
    
    func restore() async {
        await delay()
        hasPremium = premiumStatusAfterRestore ? true : false
    }
    
    private func delay() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
}
