//
//  CameraCaptureView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import SwiftUI

struct CameraCaptureView: View {
    
    @ObservedObject var vm: CameraViewModel
    
    var body: some View {
        ZStack {
//            Color.gray
//                .ignoresSafeArea()
            CameraPreviewHolder(captureSession: vm.cameraService.session)
                .ignoresSafeArea()
            
            focusFrame
        }
        .frame(maxHeight: .infinity)
        .overlay(content: {
            VStack {
                flashButton
                
                Spacer()
                
                HStack {
                    CircleButton(
                        imageIcon: .galleryIcon,
                        action: vm.galleryButtonPressed
                    )
                    
                    Spacer()
                    
                    takePhotoButton
                    
                    Spacer()
                    
                    CircleButton(
                        imageIcon: .guideIcon,
                        action: vm.guideButtonPressed
                    )
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 88)
            }
        })
        .onAppear {
            vm.startSession()
        }
        .onDisappear {
            vm.stopSession()
        }
    }
    
    var focusFrame: some View {
        Image(uiImage: .focusFrame)
            .resizable()
            .foregroundStyle(Color.textPrimaryLight)
            .scaledToFit()
            .padding(.bottom, 60)
    }
    
    var flashButton: some View {
        HStack {
            Button {
                vm.flashToggle.toggle()
            } label: {
                Image(uiImage: .flashIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(
                        vm.flashToggle
                        ? Color.appYellow
                        : Color.textTretiery
                    )
                    .padding(12)
                    .background(Color.backgroundLevel3)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .padding(.leading, 16)
            
            Spacer()
        }
    }
    
    var takePhotoButton: some View {
        Button {
            vm.takePhoto()
        } label: {
            Circle()
                .fill(Color.backgroundLevel1)
                .frame(width: 52, height: 52)
                .overlay {
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundStyle(Color.backgroundLevel1)
                        .frame(width: 60, height: 60)
                }
        }
        .buttonStyle(.plain)
    }
}

fileprivate struct CircleButton: View {
    let imageIcon: UIImage
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(uiImage: imageIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.appPrimary)
                .padding(18)
                .background(Color.backgroundLevel3)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
