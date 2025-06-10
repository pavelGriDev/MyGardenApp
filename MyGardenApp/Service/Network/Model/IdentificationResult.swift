//
//  IdentificationResult.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 10.06.25.
//

import Foundation

struct IdentificationResult: Codable {
    let isPlant: IsPlant
    let classification: Classification

    enum CodingKeys: String, CodingKey {
        case isPlant = "is_plant"
        case classification
    }
}

struct IsPlant: Codable {
    let probability: Double
    let threshold: Double
    let binary: Bool
}

struct Classification: Codable {
    let suggestions: [Suggestion]
}

struct Suggestion: Codable {
    let id: String
    let name: String
    let probability: Double
    let similarImages: [SimilarImage]?
    let details: Details?

    enum CodingKeys: String, CodingKey {
        case id, name, probability
        case similarImages = "similar_images"
        case details
    }
}

struct SimilarImage: Codable {
    let id: String
    let url: String
    let licenseName: String?
    let licenseUrl: String?
    let citation: String?
    let similarity: Double
    let urlSmall: String?

    enum CodingKeys: String, CodingKey {
        case id, url
        case licenseName = "license_name"
        case licenseUrl = "license_url"
        case citation, similarity
        case urlSmall = "url_small"
    }
}

struct Details: Codable {
    let taxonomy: Taxonomy?
    let description: Description?

    enum CodingKeys: String, CodingKey {
        case taxonomy, description
    }
}

struct Taxonomy: Codable {
    let `class`: String?
    let genus: String?
    let order: String?
    let family: String?
    let phylum: String?
    let kingdom: String?
}

struct Description: Codable {
    let value: String
    let citation: String?
    let licenseName: String?
    let licenseUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case value, citation
        case licenseName = "license_name"
        case licenseUrl = "license_url"
    }
}
