//
//  PlantsViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 08.06.25.
//

import Foundation

struct PlantsItemModel: Identifiable {
    let id = UUID()
    let name: String
}

final class PlantsViewModel: ObservableObject {
    @Published var content: [PlantsItemModel] = []
    
    func setup() {
        content = [.init(name: "F01"), .init(name: "F02")]
    }
}
