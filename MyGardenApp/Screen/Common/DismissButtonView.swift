//
//  DismissButtonView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import SwiftUI

struct DismissButtonView: View {
    @Binding var isVisible: Bool
    let action: () -> Void
    
    var body: some View {
        if !isVisible {
            Button {
                action()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.backgroundLevel2)
                        .frame(width: 48, height: 48)
                    Image(uiImage: .dismissButtonIcon)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.textTretiery)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}
