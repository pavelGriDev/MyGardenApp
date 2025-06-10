//
//  NetworkService.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import Foundation
import Alamofire

enum PlantsDetails: String {
    case taxonomy
    case description
}


final class NetworkService {
    let token = "o7ZymLnHlbWf9ssAgYalq6W739L9pDbrLh6hYR33FMQbz8f1Yw"
    
    let base = "https://plant.id/api/v3/"
    
    private var headers: HTTPHeaders {
       ["Api-Key": token]
    }
    
    func upload(
        imageData: Data,
        details: [PlantsDetails] = [.taxonomy, .description],
        completion: @escaping (Result<APIResponse<IdentificationResult>, Error>) -> Void
    ) {
        
        let url = appendDetailsToURL("\(base)identification", details: details)
        
        guard let similarValue = "\(true)".toData(),
              let healthValue = "auto".toData()
        else { return }
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: "photo.png", mimeType: "image/png")
                multipartFormData.append(similarValue, withName: "similar_images")
                multipartFormData.append(healthValue, withName: "health")
            },to: url,method: .post,headers: headers)
        .responseDecodable(of: APIResponse<IdentificationResult>.self) { response in
            switch response.result {
            case .success(let result):
                Logger.printInfo(result)
                completion(.success(result))
            case .failure(let error):
                Logger.printWarning("Error: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    private func appendDetailsToURL(_ url: String, details: [PlantsDetails]) -> String {
        guard !details.isEmpty else { return url }
        let detailsString = details.map { $0.rawValue }.joined(separator: ",")
        return "\(url)?details=\(detailsString)"
    }
}
