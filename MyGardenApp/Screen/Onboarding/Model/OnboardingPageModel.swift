//
//  OnboardingPageModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation

struct OnboardingPageModel {
    let backgroundImageName: String
    let title: String
    let bodyText: String
    let buttonTitle: String
    let isShowAppRate: Bool
}

extension OnboardingPageModel {
    static func getAll() -> [OnboardingPageModel] {
        [
            OnboardingPageModel(
                backgroundImageName: "onboardingImagePage01",
                title: "Plant identification",
                bodyText: "Snap or upload photos to accurately identify over \n30 000 plants, flowers and trees",
                buttonTitle: "Continue",
                isShowAppRate: false
            ),
            OnboardingPageModel(
                backgroundImageName: "onboardingImagePage02",
                title: "Your opinion is valuable to us",
                bodyText: "Share your experience with the app \nand help us improve it",
                buttonTitle: "Continue",
                isShowAppRate: false
            ),
            OnboardingPageModel(
                backgroundImageName: "onboardingImagePage03",
                title: "Diagnostics",
                bodyText: "After diagnosing your plant, we will tell you \nhow to treat it",
                buttonTitle: "Continue",
                isShowAppRate: true
            )
        ]
    }
}
