//
//  MyGardenViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 08.06.25.
//

import Foundation

final class MyGardenViewModel: ObservableObject {
    @Published var currentTab: MyGardenTab = .plants
    
    func topTabButtonPressed(with model: MyGardenTab) {
        currentTab = model
    }
}
