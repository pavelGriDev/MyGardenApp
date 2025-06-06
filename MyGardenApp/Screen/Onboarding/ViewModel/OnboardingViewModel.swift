//
//  OnboardingViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

final  class OnboardingViewModel: ObservableObject {
    @Published var currentIndex = 0
    private(set) var content: [OnboardingPageModel] = OnboardingPageModel.getAll()
    
    private var finishOnboarding: () -> Void
     
    init(_ finishOnboarding: @escaping () -> Void) {
        self.finishOnboarding = finishOnboarding
    }
    
    func continueButtonPressed() {
        print(#function)
        
        if currentIndex + 1 < content.count {
            currentIndex += 1
        } else {
            finishOnboarding()
        }
    }
    
    func termsButtonPressed() {
        print(#function)
    }
    
    func restoreButtonPressed() {
        print(#function)
    }
    
    func privacyButtonPressed() {
        print(#function)
    }
}
