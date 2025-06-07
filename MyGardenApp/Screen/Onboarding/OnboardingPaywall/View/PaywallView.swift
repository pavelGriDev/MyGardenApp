//
//  OnboardingPaywallView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI
import NavigationBackport

struct OnboardingPaywallView: View {
    @EnvironmentObject var navigator: PathNavigator
    @Environment(\.openURL) var openUrl
    @StateObject private var vm = PaywallViewModel({})
    
    var body: some View {
        VStack {
            backgroundImage
            
            Spacer()
        }
        .overlay(
            content: {
                VStack {
                    Spacer()
                    
                    VStack(spacing: 12) {
                        textContent
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.backgroundLevel2)
                            .frame(height: 55)
                            .overlay {
                                Toggle(
                                    isOn: $vm.freeTrialToggle,
                                    label: {
                                Text(vm.content.toggleTitle)
                                    .font(.customFont(.regular, size: 14))
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                    .foregroundStyle(Color.textPrimary)
                            })
                            .padding(.horizontal, 16)
                        }
                    
                    ProgressButton(
                        title: vm.content.buttonTitle,
                        showProgress: $vm.showProgress,
                        action: vm.continueButtonPressed
                    )
                    
                    ActionFooterView(
                        termsAction: termsAction,
                        restoreAction: vm.restoreButtonPressed,
                        privacyAction: privacyAction
                    )
                }
                .padding(.horizontal, 16.0)
            }
        })
        .backgroundColor()
        .onAppear { vm.setup() }
        .onDisappear { vm.onDisappear() }
    }
    
    private func termsAction() {
        vm.termsButtonPressed { url in
            openUrl(url)
        }
    }
    
    private func privacyAction() {
        vm.termsButtonPressed { url in
            openUrl(url)
        }
    }
}

#Preview {
    OnboardingPaywallView()
}

extension OnboardingPaywallView {
    var backgroundImage: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: .paywallBackground)
                .resizable()
                .scaledToFit()
            
            Image(uiImage: .premiumPerks)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 34)
                .padding(.bottom, 24)
        }
    }
    
    var textContent: some View {
        VStack(spacing: 8) {
            Text(vm.content.title)
                .font(.customFont(.semiBold, size: 20))
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
            
            Text(
                vm.freeTrialToggle
                ? vm.content.bodyTextIfTrial
                : vm.content.bodyText
            )
            .font(.customFont(.regular, size: 14))
            .foregroundStyle(Color.textSecondary)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.9)
        }
    }
}
