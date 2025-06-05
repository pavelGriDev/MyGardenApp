//
//  RootView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI
import NavigationBackport

struct RootView: View {
    
    @StateObject private var vm = RootViewModel()
    @State private var path = NBNavigationPath()
    
    var body: some View {
        NBNavigationStack(path: $path) {
            Group {
                switch vm.currentScreen {
                case .launch:
                    Text("launch")
                case .onboarding:
                    Text("onboarding")
                case .main:
                    Text("main")
                }
            }
        }
    }
}

#Preview {
    RootView()
}
