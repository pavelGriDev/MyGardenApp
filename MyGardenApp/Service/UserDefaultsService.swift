//
//  UserDefaultsServiceImp.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import Foundation

protocol UserDefaultsService {
    func setFlag(_ key: UserDefaultsServiceImp.Key, value: Bool)
    func getFlag(_ key: UserDefaultsServiceImp.Key) -> Bool
}

final class UserDefaultsServiceImp: UserDefaultsService {
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
