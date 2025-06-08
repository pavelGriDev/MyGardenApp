//
//  PlantsView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct PlantsView: View {
    
    @StateObject private var vm = PlantsViewModel()
    
    let rows: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            switch vm.content.isEmpty {
            case true:
                MyGardenEmptyView(action: { })
            case false:
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: rows, spacing: 12) {
                        ForEach(0..<20) { _ in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.backgroundLevel2)
                                .frame(height: 218)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
        .padding(.top, 96)
        .overlay(content: {
            NavigationBarWithTitle(title: "My Garden")
        })
        .backgroundColor()
    }
}

#Preview {
    PlantsView()
}

final class PlantsViewModel: ObservableObject {
    @Published var content: [String] = []
}
