//
//  CameraView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var vm = CameraViewModel()
    
    var body: some View {
        switch vm.userImage {
        case .none:
            CameraCaptureView(vm: vm)
        case .some(let image):
            CameraPhotoReviewView(vm: vm, image: image)
        }
    }
}

#Preview {
    CameraView()
}
