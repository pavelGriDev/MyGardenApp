//
//  SettingsView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.openURL) var openUrl
    @StateObject private var vm = SettingsViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(SettingsContentModel.allCases) { model in
                    switch model {
                    case .notifications:
                        CellWithToggle(toggleValue: $vm.notificationsToggle, title: model.title)
                    default:
                        CellWithAction(title: model.title) {
                            vm.cellButtonPressed(with: model) { url in
                                openUrl(url)
                            }
                        }
                    }
                }
            }
            .padding(.top, 20)
            .padding(.horizontal, 16)
        }
        .backgroundColor()
        .padding(.top, 48)
        .overlay {
            NavigationBarWithTitle(title: "Settings")
        }
        .errorAlert(error: $vm.appError)
        .openSettingAlert(
            isPresented: $vm.showSettingsAlert,
            model: vm.settingAlertModel,
            openAction: vm.openPhoneSettings,
            cancelAction: vm.cancelAlert
        )
        .shareSheet(isPresented: $vm.showActivity, items: vm.data)
        .onAppear { vm.setup() }
    }
}

#Preview {
    SettingsView()
}

fileprivate struct CellWithToggle: View {
    @Binding var toggleValue: Bool
    let title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .frame(height: 76)
            .overlay {
                Toggle(isOn: $toggleValue) {
                    Text(title)
                        .font(.customFont(.regular, size: 16))
                        .foregroundStyle(Color.textPrimary)
                        .lineLimit(1)
                }
                .tint(Color.appPrimary)
                .padding(.horizontal, 16)
            }
    }
}

fileprivate struct CellWithAction: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(height: 76)
                .overlay {
                    HStack {
                        Text(title)
                            .font(.customFont(.regular, size: 16))
                            .foregroundStyle(Color.textPrimary)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
        }
        .buttonStyle(.plain)
    }
}
