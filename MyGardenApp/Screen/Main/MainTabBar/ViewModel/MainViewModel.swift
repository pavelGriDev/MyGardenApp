//
//  MainViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import Foundation
import AVFoundation

final class MainViewModel: ObservableObject {
    @Published var currentTab: TabModel = .myGarden
    
    func tabButtonPressed(with tab: TabModel) {
        switch tab {
        case .myGarden:
            currentTab = tab
        case .camera where verifyCameraAuthorization() == true:
//        case .camera:
            currentTab = tab
        case .settings:
            currentTab = tab
        default:
            break
        }
    }
    
    private func verifyCameraAuthorization() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            requestCameraPermission()
            return false
        case .authorized:
            Logger.printInfo("Open the camera")
            return true
        default:
            Logger.printInfo("Show the alert")
            return false
        }
    }

    func requestCameraPermission() {
        Task {
            if await AVCaptureDevice.requestAccess(for: .video) {
                Logger.printInfo("Open the camera")
                await MainActor.run {
                    currentTab = .camera
                }
            }
        }
    }
}
