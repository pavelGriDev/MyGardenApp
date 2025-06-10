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
        
        self.cameraService.imageCaptureCompletion = { [weak self] imageData in
            guard let image = UIImage(data: imageData) else {
                DispatchQueue.main.async {
                    self?.appError = AppError.unknown
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.userImage = image
            }
        }
    }
    
    func startSession() {
        cameraService.controllSession(start: true)
    }
    
    func stopSession() {
        cameraService.controllSession(start: false)
    }
    
    func onDisappear() {
        userImage = nil
    }
    
    func takePhoto() {
        cameraService.takePhoto(withFlash: flashToggle)
    }
    
    func galleryButtonPressed() {
        // TODO: _
    }
    
    func guideButtonPressed() {
        // TODO: _
    }
    
    func retakeButtonPressed() {
        userImage = nil
    }
    
    func identificationButtonPressed(completion: () -> Void) {
        completion()
    }
    
    func diagnosticsButtonPressed() {
        
    }
}
