//
//  CameraViewModel.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import Foundation
import UIKit.UIImage

final class CameraViewModel: ObservableObject {
    @Published var flashToggle: Bool = true
    @Published var userImage: UIImage?
    @Published var appError: Error?
    
    let cameraService: CameraService
    
    init(
        cameraService: CameraService = CameraServiceImp.shared
    ) {
        self.cameraService = cameraService
        
        self.cameraService.captureErrorCompletion = { [weak self] error in
            self?.appError = error
        }
    }
    
    func startSession() {
        cameraService.controllSession(start: true)
    }
    
    func stopSession() {
        cameraService.controllSession(start: false)
    }
    
    func takePhoto() {
        cameraService.takePhoto(withFlash: flashToggle)
    }
    
    func galleryButtonPressed() {
        
    }
    
    func guideButtonPressed() {
        
    }
}
