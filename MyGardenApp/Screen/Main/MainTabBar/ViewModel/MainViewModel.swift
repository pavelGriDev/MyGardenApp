//
//  MainViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var currentTab: TabModel = .myGarden
}
