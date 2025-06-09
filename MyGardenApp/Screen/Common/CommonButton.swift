//
//  CommonButton.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import SwiftUI

struct CommonButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Capsule()
                .fill(Color.appPrimary)
                .frame(height: 48)
                .overlay {
                    Text(title)
                        .font(.customFont(.semiBold, size: 16))
                        .foregroundStyle(Color.textPrimaryLight)
                        .lineLimit(1)
                }
        }
    }
}
