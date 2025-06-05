//
//  MyGardenView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

enum MyGardenScreen {
    case plants
    case history
}

struct MyGardenView: View {
    @ObservedObject private var vm = MyGardenViewModel()
    var body: some View {
        TabView(selection: $vm.currentScreen) {
            PlantsView()
                .onAppear { Logger.printInfo("Plants view onAppear") }
                .tag(MyGardenScreen.plants)
            HistoryView()
                .onAppear { Logger.printInfo("History view onAppear") }
                .tag(MyGardenScreen.history)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            VStack {
                HStack {
                    Button("plants") { vm.currentScreen = .plants }
                    Button("history") { vm.currentScreen = .history }
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MyGardenView()
}

final class MyGardenViewModel: ObservableObject {
    @Published var currentScreen: MyGardenScreen = .plants
}
