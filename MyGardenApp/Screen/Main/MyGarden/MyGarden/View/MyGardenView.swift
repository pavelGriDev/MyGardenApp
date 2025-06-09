//
//  MyGardenView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct MyGardenView: View {
    @ObservedObject private var vm = MyGardenViewModel()
    var body: some View {
        TabView(selection: $vm.currentTab) {
            PlantsView()
                .tag(MyGardenTab.plants)
            HistoryView()
                .tag(MyGardenTab.history)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .overlay(content: {
            NavigationBarWithTitle(title: "My Garden")
        })
        .overlay {
            VStack {
                TopTabMenu(
                    currentTab: $vm.currentTab,
                    tabAction: vm.topTabButtonPressed(with:)
                )
                .padding(.top, 48)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MyGardenView()
}

fileprivate struct TopTabMenu: View {
    @Binding var currentTab: MyGardenTab
    let tabAction: (MyGardenTab) -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(MyGardenTab.allCases) { model in
                Button {
                    tabAction(model)
                } label: {
                    Text(model.title)
                        .font(.customFont(
                            currentTab == model
                            ? .semiBold
                            : .regular,
                            size: 16)
                        )
                        .foregroundStyle(
                            currentTab == model
                            ? Color.backgroundLevel2
                            : Color.appPrimary
                        )
                        .padding(.vertical, 11)
                        .frame(width: 120)
                        .background(
                            currentTab == model
                            ? Color.appPrimary
                            : Color.backgroundLevel2
                        )
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .frame(height: 56, alignment: .top)
    }
}
