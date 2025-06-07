//
//  NavigationBarWithTitle.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import SwiftUI

struct NavigationBarWithTitle: View {
    private let height: CGFloat = 48
    
    let title: String
    
    var body: some View {
        ZStack {
            Color.backgroundLevel1
                .ignoresSafeArea()
            
            Text(title)
                .font(.customFont(.semiBold, size: 20))
                .foregroundStyle(Color.textPrimary)
                .lineLimit(1)
        }
        .frame(height: height)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
