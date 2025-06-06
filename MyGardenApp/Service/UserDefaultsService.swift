//
//  UserDefaultsService.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import Foundation

protocol UserDefaultsProtocol {
    func setFlag(_ key: UserDefaultsService.Key, value: Bool)
    func getFlag(_ key: UserDefaultsService.Key) -> Bool
}

final class UserDefaultsService: UserDefaultsProtocol {
    private let defaults = UserDefaults.standard
    
    enum Key: String {
        case onboardingCompleted
    }
    
    func setFlag(_ key: Key, value: Bool) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func getFlag(_ key: Key) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }
}
