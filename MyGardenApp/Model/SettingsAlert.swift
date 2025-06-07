//
//  SettingsAlertModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import Foundation

enum SettingAlert {
    case gallery
    case camera
    case notifications
    case empty
    
    var title: String {
       switch self {
        case .gallery:
            "Photo Library"
        case .camera:
            "Camera"
       case .notifications:
           "Notifications"
        case .empty:
            ""
        }
    }
    
    var message: String {
        "message"
    }
}
