//
//  HistoryViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 08.06.25.
//

import Foundation

struct HistoryItemModel: Identifiable {
    let id = UUID()
    let name: String
}

final class HistoryViewModel: ObservableObject {
    @Published var content: [HistoryItemModel] = []
    
    func setup() {
//        content = [.init(name: "F01")]
    }
}
