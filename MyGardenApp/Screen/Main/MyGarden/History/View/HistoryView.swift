//
//  HistoryView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct HistoryView: View {
    
    @StateObject private var vm = HistoryViewModel()
    
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
                        ForEach($vm.content) { item in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.backgroundLevel2)
                                .frame(height: 218)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
            }
        }
        .padding(.top, 96)
        .backgroundColor()
        .onAppear { vm.setup() }
    }
}

#Preview {
    HistoryView()
}
