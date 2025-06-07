//
//  OverlayPaywallView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import SwiftUI

struct OverlayPaywallView: View {
    @Environment(\.openURL) var openUrl
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = OverlayPaywallViewModel()
    
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
                    
                    ProgressButton(
                        title: vm.content.buttonTitle,
                        showProgress: $vm.showProgress,
                        action: continueButtonAction
                    )
                    
                    ActionFooterView(
                        termsAction: termsButtonAction,
                        restoreAction: restoreButtonAction,
                        privacyAction: privacyButtonAction
                    )
                }
                .padding(.horizontal, 16.0)
            }
        })
        .overlay(content: {
            VStack {
                HStack {
                    Spacer()
                    
                    DismissButtonView(isVisible: $vm.showProgress, action: dismissAction)
                        .padding(.top, 4)
                        .padding(.trailing, 20)
                }
                
                Spacer()
            }
        })
        .backgroundColor()
        .onAppear { vm.setup() }
        .onDisappear { vm.onDisappear() }
    }
    
    private func continueButtonAction() {
        vm.continueButtonPressed() {
            dismiss()
        }
    }
    
    private func termsButtonAction() {
        vm.termsButtonPressed { url in
            openUrl(url)
        }
    }
    
    private func restoreButtonAction() {
        vm.restoreButtonPressed() {
            dismiss()
        }
    }
    
    private func privacyButtonAction() {
        vm.termsButtonPressed { url in
            openUrl(url)
        }
    }
    
    private func dismissAction() {
        vm.dismissButtonPressed() {
            dismiss()
        }
    }
}

#Preview {
    OverlayPaywallView()
}

extension OverlayPaywallView {
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
            
            Text(vm.content.bodyText)
            .font(.customFont(.regular, size: 14))
            .foregroundStyle(Color.textSecondary)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.9)
        }
    }
}
