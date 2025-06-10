//
//  HealthResult.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 10.06.25.
//

import Foundation

struct HealthResult: Codable {
    let isHealthy: IsHealthy
    let disease: Disease
    let isPlant: IsPlant
    
    enum CodingKeys: String, CodingKey {
        case isHealthy = "is_healthy"
        case disease
        case isPlant = "is_plant"
    }
}

struct IsHealthy: Codable {
    let binary: Bool
    let threshold: Double
    let probability: Double
}

struct Disease: Codable {
    let suggestions: [DiseaseSuggestion]
//    let question: Question?
}

struct DiseaseSuggestion: Codable {
    let id: String
    let name: String
    let probability: Double
    let similarImages: [SimilarImage]?
    let details: DiseaseDetails?
    
    enum CodingKeys: String, CodingKey {
        case id, name, probability
        case similarImages = "similar_images"
        case details
    }
}

struct DiseaseDetails: Codable {
    let localName: String?
    let description: String?
    let url: String?
    let treatment: Treatment?
    let classification: [String]?
    let commonNames: [String]?
    let cause: String?
    let language: String?
    let entityId: String?
    
    enum CodingKeys: String, CodingKey {
        case localName = "local_name"
        case description, url, treatment, classification
        case commonNames = "common_names"
        case cause
        case language
        case entityId = "entity_id"
    }
}

struct Treatment: Codable {
    let chemical: [String]?
    let biological: [String]?
    let prevention: [String]?
}
