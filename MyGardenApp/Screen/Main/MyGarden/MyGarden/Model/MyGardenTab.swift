//
//  MyGardenTab.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 08.06.25.
//

import Foundation

enum MyGardenTab: CaseIterable, Identifiable {
    case plants
    case history
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .plants:
            "Plants"
        case .history:
            "History"
        }
    }
}
