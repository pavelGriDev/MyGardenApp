//
//  ProgressButton.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import SwiftUI

struct ProgressButton: View {
    let title: String
    @Binding var showProgress: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Capsule()
                .fill(Color.appPrimary)
                .frame(height: 48)
                .overlay {
                    if showProgress {
                        // TODO: спросить про анимацию для лоти
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.2)
                    } else {
                        Text(title)
                            .font(.customFont(.semiBold, size: 16))
                            .foregroundStyle(Color.textPrimaryLight)
                            .lineLimit(1)
                    }
                }
        }
    }
}

#Preview {
    VStack {
        ProgressButton(title: "Continue" , showProgress: .constant(true), action: { })
    }
    .padding(.horizontal, 16)
}
