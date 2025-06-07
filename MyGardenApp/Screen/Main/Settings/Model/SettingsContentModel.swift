//
//  SettingsContentModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

enum SettingsContentModel: CaseIterable, Identifiable {
    case notifications
    case privacyPolicy
    case termsOfUse
    case support
    case shareApp
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .notifications:
            "Notifications"
        case .privacyPolicy:
            "Privacy policy"
        case .termsOfUse:
            "Terms of use"
        case .support:
            "Support"
        case .shareApp:
            "Share app"
        }
    }
}
