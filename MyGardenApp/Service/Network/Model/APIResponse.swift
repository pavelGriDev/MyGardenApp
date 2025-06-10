//
//  APIResponse.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 10.06.25.
//

import Foundation


struct APIResponse<ResultType: Decodable>: Decodable {
    let accessToken: String
    let modelVersion: String
    let customId: String?
    let input: InputData
    let result: ResultType
    let status: String
    let slaCompliantClient: Bool
    let slaCompliantSystem: Bool
    let created: Double
    let completed: Double
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case modelVersion = "model_version"
        case customId = "custom_id"
        case input, result, status
        case slaCompliantClient = "sla_compliant_client"
        case slaCompliantSystem = "sla_compliant_system"
        case created, completed
    }
}


struct InputData: Codable {
    let latitude: Double?
    let longitude: Double?
    let similarImages: Bool
    let images: [String]
    let datetime: String
    let health: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case similarImages = "similar_images"
        case images, datetime, health
    }
}
