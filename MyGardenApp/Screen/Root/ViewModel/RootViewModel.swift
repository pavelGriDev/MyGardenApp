//
//  RootViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

final class RootViewModel: ObservableObject {
    private(set) var currentScreen: StartScreen = .launch
}
