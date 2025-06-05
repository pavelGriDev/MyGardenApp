//
//  RootViewModelTest.swift
//  MyGardenAppTests
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Testing
@testable import MyGardenApp

struct RootViewModelTest {

    @Test func startSetup() async throws {
        let sut = RootViewModel()
        
        #expect(sut.currentScreen == .launch)
    }

}
