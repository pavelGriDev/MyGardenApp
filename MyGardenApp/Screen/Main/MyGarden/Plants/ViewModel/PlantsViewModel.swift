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
        content = [
            .init(name: "F01"), .init(name: "F01"),
            .init(name: "F02"), .init(name: "F02"),
            .init(name: "F03"), .init(name: "F03"),
            .init(name: "F04"), .init(name: "F04"),
            .init(name: "F05"), .init(name: "F05"),
            .init(name: "F06"), .init(name: "F06"),
            .init(name: "F07"), .init(name: "F07"),
            .init(name: "F08"), .init(name: "F08"),
            .init(name: "F09"), .init(name: "F09"),
            .init(name: "F10"), .init(name: "F10"),
        ]
    }
}
