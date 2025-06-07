//
//  OnboardingPageView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import SwiftUI
import NavigationBackport

struct OnboardingPageView: View {
    @EnvironmentObject var navigator: PathNavigator
    @Environment(\.openURL) var openUrl
    
    let model: OnboardingPageModel
    @ObservedObject var vm: OnboardingViewModel
    
    var body: some View {
        VStack {
            Image(model.backgroundImageName)
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        .overlay {
            VStack {
                Spacer()
                
                VStack(spacing: 12) {
                    VStack(spacing: 8) {
                        Text(model.title)
                            .font(.customFont(.semiBold, size: 20))
                            .foregroundStyle(Color.textPrimary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.9)
                        
                        Text(model.bodyText)
                            .font(.customFont(.regular, size: 14))
                            .foregroundStyle(Color.textSecondary)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.9)
                    }
                    
                    ProgressButton(
                        title: model.buttonTitle,
                        showProgress: $vm.showProgress,
                        action: {
                            withAnimation {
                                vm.continueButtonPressed() {
                                    navigator.push(AppRouterModel.paywall)
                                }
                            }
                        }
                    )
                    
                    ActionFooterView(
                        termsAction: termsButtonAction,
                        restoreAction: vm.restoreButtonPressed,
                        privacyAction: privacyButtonAction
                    )
                }
                .padding(.horizontal, 16.0)
            }
        }
    }
    
    private func termsButtonAction() {
        vm.termsButtonPressed { url in
            openUrl(url)
        }
    }
    
    private func privacyButtonAction() {
        vm.termsButtonPressed { url in
            openUrl(url)
        }
    }
}

