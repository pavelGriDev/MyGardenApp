//
//  MainTabBarView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct MainTabBarView: View {
    @StateObject private var vm = MainViewModel()
    
    var body: some View {
        TabView(selection: $vm.currentTab) {
            Group {
                MyGardenView()
                    .tag(TabModel.myGarden)
                CameraView()
                    .onAppear { Logger.printInfo("CameraView onAppear") }
                    .tag(TabModel.camera)
                SettingsView()
                    .onAppear { Logger.printInfo("SettingsView onAppear") }
                    .tag(TabModel.settings)
            }
            .tabViewDisableSwiping()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
        .backgroundColor()
        .onAppear { Logger.printInfo("MainTabBarView onAppear") }
        .overlay {
            VStack {
                Spacer()
                
                TabBarMenu(
                    currentTab: $vm.currentTab,
                    tabAction: vm.tabButtonPressed(with:)
                )
                .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    MainTabBarView()
}

fileprivate struct TabBarMenu: View {
    
    @Binding var currentTab: TabModel
    let tabAction: (TabModel) -> Void
    
    var body: some View {
        HStack {
            ForEach(TabModel.allCases) { model in
                Button {
                    tabAction(model)
                } label: {
                    Image(model.tabImageName)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(
                            currentTab == model
                            ? Color.appPrimary
                            : Color.textTretiery
                        )
                        .frame(height: 24)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 16)
                }
                .buttonStyle(.plain)
            }
        }
        .background(Color.backgroundLevel2)
        .clipShape(Capsule())
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 30, x: 0, y: 4
        )
    }
}
