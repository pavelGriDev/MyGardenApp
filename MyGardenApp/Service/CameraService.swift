//
//  CameraService.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import Foundation
import AVFoundation

protocol CameraService: AnyObject {
    var session: AVCaptureSession { get }
    var imageCaptureCompletion: ((Data) -> Void)? { get set }
    var captureErrorCompletion: ((CameraServiceError) -> Void)? { get set }
    func controllSession(start: Bool)
    func takePhoto(withFlash flash: Bool)
}

final class CameraServiceImp: NSObject, CameraService {
    static let shared = CameraServiceImp()
    
    var session = AVCaptureSession()
    var imageCaptureCompletion: ((Data) -> Void)?
    var captureErrorCompletion: ((CameraServiceError) -> Void)?
    
    private let sessionQueue = DispatchQueue(label: "cameraSessionQueue")
    private let photoOutput = AVCapturePhotoOutput()
    private var isSessionConfigureted = false
    
    func controllSession(start: Bool) {
        if !isSessionConfigureted {
            sessionQueue.async {
                self.setCaptureSession()
            }
        }
        
        if start {
            sessionQueue.async {
                self.session.startRunning()
            }
        } else {
            sessionQueue.async {
                self.session.stopRunning()
            }
        }
    }
    
    func takePhoto(withFlash flash: Bool) {
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = flash ? .on : .off
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    private func setCaptureSession() {
        guard !isSessionConfigureted else { return }
        
        session.beginConfiguration()
        defer { session.commitConfiguration() }
        
        session.sessionPreset = .high

        setupInput()
        setupOutput()

        isSessionConfigureted = true
    }
    
    private func setupInput() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            captureErrorCompletion?(.cameraUnavailable)
            return
        }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: device),
                    session.canAddInput(videoDeviceInput)
        else {
            captureErrorCompletion?(.cannotAddInput)
            return
        }
        
        session.addInput(videoDeviceInput)
    }
    
    private func setupOutput() {
        guard session.canAddOutput(photoOutput) else {
            return
        }
        
        photoOutput.isHighResolutionCaptureEnabled = true
        photoOutput.maxPhotoQualityPrioritization = .balanced
        session.addOutput(photoOutput)
    }
}


// MARK: AVCapturePhotoCaptureDelegate

extension CameraServiceImp: AVCapturePhotoCaptureDelegate {
    func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: (any Error)?
    ) {
        guard error == nil else {
            captureErrorCompletion?(.createCaptureInput(error!))
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            return
        }
        
        imageCaptureCompletion?(imageData)
    }
}


// MARK: CameraServiceError

enum CameraServiceError: Error, LocalizedError {
    case cameraUnavailable
    case cannotAddInput
    case cannotAddOutput
    case createCaptureInput(Error)
    
    var errorDescription: String? {
        switch self {
        case .cameraUnavailable:
            return "Camera unavailable"
        case .cannotAddInput:
            return "Cannot add capture input to session"
        case .cannotAddOutput:
            return "Cannot add video output to session"
        case .createCaptureInput(let error):
            return "Creating capture input for camera: \(error.localizedDescription)"
        }
    }
}
