//
//  OnboardingViewModelTest.swift
//  MyGardenAppTests
//
//  Created by Pavel Gritskov on 06.06.25.
//

import Testing
@testable import MyGardenApp

struct OnboardingViewModelTest {

    @Test func initial() {
        let closure: () -> Void = {}
        let sut = OnboardingViewModel(closure)
        
        #expect(sut.currentIndex == 0)
        #expect(sut.content.count == 3)
    }
    
    @Test func continueButtonPressed_currentIndexIsOne() async throws {
        let closure: () -> Void = {}
        let sut = OnboardingViewModel(closure)
        
        sut.continueButtonPressed({})
        
        #expect(sut.currentIndex == 1)
    }
    
    @Test func continueButtonPressed_productIsNil_finishOnboarding() async throws {
        var value = 0
        var finishOnboarding: Bool = false
        var callCompletion: Bool = false
        let closure: () -> Void = { finishOnboarding = true }
        let completion: () -> Void = {
            callCompletion = true
            value += 1
        }
        let service = MockPurchaseService()
        let sut = OnboardingViewModel(closure, service)
        
        sut.continueButtonPressed(completion)
        sut.continueButtonPressed(completion)
        sut.continueButtonPressed(completion)
        
        #expect(sut.currentIndex == 2)
        #expect(callCompletion == false)
        #expect(finishOnboarding == true)
        #expect(value == 0)
    }
    
    @Test func continueButtonPressed_showPaywall() async throws {
        var finishOnboarding: Bool = false
        var callCompletion: Bool = false
        let closure: () -> Void = { finishOnboarding = true }
        let completion: () -> Void = { callCompletion = true }
        let service = MockPurchaseService()
        let sut = OnboardingViewModel(closure, service)
        
        await service.getPaywalls()
        
        sut.continueButtonPressed(completion)
        sut.continueButtonPressed(completion)
        sut.continueButtonPressed(completion)
        
        #expect(sut.currentIndex == 2)
        #expect(callCompletion == true)
        #expect(finishOnboarding == false)
    }
}
