//
//  MyGardenEmptyView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 08.06.25.
//

import SwiftUI

struct MyGardenEmptyModel {
    let title: String
    let bodyText: String
    let buttonTitle: String
    
    static let getModel = MyGardenEmptyModel(
        title: "There are no plants in your garden yet",
        bodyText: "Identify your first plant using the camera \nor upload a photo",
        buttonTitle: "Open the camera"
    )
}

struct MyGardenEmptyView: View {
    
    private let model = MyGardenEmptyModel.getModel
    let action: () -> Void
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ZStack {
                    Image(uiImage: .bannerBackground)
                        .resizable()
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    VStack(spacing: 4) {
                        Text(model.title)
                            .foregroundStyle(Color.textSecondary)
                            .lineLimit(1)
                        Text(model.bodyText)
                            .foregroundStyle(Color.textPrimary)
                            .lineLimit(2)
                        
                        Button {
                            action()
                        } label: {
                            ZStack {
                                Capsule()
                                    .fill(Color.appPrimary)
                                    .frame(width: 240, height: 48)
                                
                                Text(model.buttonTitle)
                                    .font(.customFont(.semiBold, size: 16))
                                    .foregroundStyle(Color.textPrimaryLight)
                            }
                        }
                        .padding(.top, 8)
                        .buttonStyle(.plain)
                    }
                    .font(.customFont(.regular, size: 14))
                    .multilineTextAlignment(.center)
                }
            }
            .frame(height: 170)
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}
