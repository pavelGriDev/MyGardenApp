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
            Text("garden")
                .tag(TabModel.myGarden)
            Text("camera")
                .tag(TabModel.camera)
            Text("settings")
                .tag(TabModel.settings)
        }
    }
}

#Preview {
    MainTabBarView()
}
