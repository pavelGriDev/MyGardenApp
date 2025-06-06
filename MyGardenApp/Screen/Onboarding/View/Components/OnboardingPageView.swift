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
                
                VStack(spacing: 8.0) {
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
                    
                    Button {
                        withAnimation {
                            vm.continueButtonPressed() {
                                navigator.push(AppRouterModel.paywall)
                            }
                        }
                    } label: {
                        Capsule()
                            .fill(Color.appPrimary)
                            .frame(height: 48)
                            .overlay {
                                Text(model.buttonTitle)
                                    .font(.customFont(.semiBold, size: 16))
                                    .foregroundStyle(Color.textPrimaryLight)
                                    .lineLimit(1)
                            }
                    }
                    .padding(.top, 4)
                    
                    ActionFooterView(
                        termsAction: vm.termsButtonPressed,
                        restoreAction: vm.restoreButtonPressed,
                        privacyAction: vm.privacyButtonPressed
                    )
                }
                .padding(.horizontal, 16.0)
            }
        }
    }
}
