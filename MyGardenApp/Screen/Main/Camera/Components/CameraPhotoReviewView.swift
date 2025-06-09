//
//  CameraPhotoReviewView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import SwiftUI

struct CameraPhotoReviewView: View {
    @ObservedObject var vm: CameraViewModel
    let image: UIImage
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.red.opacity(0.4)
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: proxy.size.height)
                    .position(
                        x: proxy.size.width / 2,
                        y: proxy.size.height / 2
                    )
            }
        }
        .ignoresSafeArea()
        .overlay {
            VStack {
                HStack {
                    Spacer()
                    
                    CircleButton(
                        imageIcon: .dismissButtonIcon,
                        style: .small,
                        iconColor: .textPrimary,
                        action: vm.retakeButtonPressed
                    )
                }
                
                Spacer()
                
                HStack(spacing: 8) {
                    CommonButton(
                        title: "Identification",
                        action: vm.identificationButtonPressed
                    )
                    CommonButton(
                        title: "Diagnostics",
                        action: vm.diagnosticsButtonPressed
                    )
                }
                .frame(height: 60)
                .padding(.bottom, 88)
                
            }
            .padding(.horizontal, 16)
        }
    }
}
