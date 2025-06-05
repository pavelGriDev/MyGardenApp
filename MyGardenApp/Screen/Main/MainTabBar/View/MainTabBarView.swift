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
            MyGardenView()
                .onAppear { Logger.printInfo("MyGardenView onAppear") }
                .tag(TabModel.myGarden)
            CameraView()
                .onAppear { Logger.printInfo("CameraView onAppear") }
                .tag(TabModel.camera)
            SettingsView()
                .onAppear { Logger.printInfo("SettingsView onAppear") }
                .tag(TabModel.settings)
        }
        .onAppear { Logger.printInfo("MainTabBarView onAppear") }
        .overlay {
            HStack {
                Button("garden") { vm.currentTab = .myGarden }
                Button("camera") { vm.currentTab = .camera }
                Button("settings") { vm.currentTab = .settings }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    MainTabBarView()
}
