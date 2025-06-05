//
//  Logger.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

final class Logger {
    static func printItems(_ items: Any...) {
        #if DEBUG
        print("-->", items)
        #endif
    }
    
    static func printWarning(_ items: Any...) {
        #if DEBUG
        print("⚠️", items)
        #endif
    }
    
    static func printInfo(_ items: Any...) {
        #if DEBUG
        print("ℹ️", items)
        #endif
    }
    
}
