//
//  AppErrorModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

enum AppError: Error, LocalizedError {
    case failedRestore
    case unknown
    
    var errorDescription: String? {
        switch self {
        default:
            "Unknown Error"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        default:
            "Unknown error"
        }
    }
}
