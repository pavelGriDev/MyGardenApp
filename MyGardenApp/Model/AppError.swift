//
//  AppErrorModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

enum AppError: Error, LocalizedError {
    case failedPurchase
    case failedRestore
    case unknown
    
    var errorDescription: String? {
        switch self {
        default:
            "Error"
        }
    }
    
    var recoverySuggestion: String? {
        nil
    }
}
