//
//  TabModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

enum TabModel: CaseIterable, Identifiable {
    case myGarden
    case camera
    case settings
    
    var id: Self { self }
    
    var tabImageName: String {
        switch self {
        case .myGarden:
            "gardenIcon"
        case .camera:
            "cameraIcon"
        case .settings:
            "settingsIcon"
        }
    }
}
