//
//  AppInteractionService.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation
import StoreKit

protocol AppInteractionService {
    var appLink: URL? { get }
    var privacyLink: URL? { get }
    var termsLink: URL? { get }
    var supportLink: URL? { get }
    func requestAppReview()
    func openSettings()
}

protocol SettingsNavigable {
    func openSettings()
}

final class AppInteractionServiceImp: AppInteractionService, SettingsNavigable {
    
    var appLink: URL? {
        URL(string: "https://apps.apple.com/pl/app/1595795215")
    }
    
    var privacyLink: URL? {
        URL(string: "https://docs.google.com/document/d/1wY6VO-Xg6DStAav4ywjC236OuebpvqHqjIliZdMz9LE/edit?usp=sharing")
    }
    
    var termsLink: URL? {
        URL(string: "https://docs.google.com/document/d/1HOGEoKmiRYtQK_7kFne9oKCUmijPSSbhrYnzS1hzsAo/edit?usp=sharing")
    }
    
    var supportLink: URL? {
        URL(string: "mailto:example@google.com")
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func requestAppReview() {
        if let windowScene = UIApplication.shared.connectedScenes
            .first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
