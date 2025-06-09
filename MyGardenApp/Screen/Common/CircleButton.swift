//
//  CircleButton.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import SwiftUI

struct CircleButton: View {
    let imageIcon: UIImage
    let style: ButtonStyle
    let iconColor: Color
    let action: () -> Void
    
    init(
        imageIcon: UIImage,
        style: ButtonStyle,
        iconColor: Color = .appPrimary,
        action: @escaping () -> Void
    ) {
        self.imageIcon = imageIcon
        self.style = style
        self.iconColor = iconColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(uiImage: imageIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(iconColor)
                .padding(style.paddingValue)
                .background(Color.backgroundLevel3)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
    
    enum ButtonStyle {
        case small
        case medium
        
        var paddingValue: CGFloat {
            switch self {
            case .small:
                12
            case .medium:
                18
            }
        }
    }
}
