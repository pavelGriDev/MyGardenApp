//
//  IdentificationView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import SwiftUI

struct IdentificationView: View {
    
    @StateObject private var vm = IdentificationViewModel()
    
    var body: some View {
        Group {
            switch vm.content.isEmpty {
            case true:
                LoadingView()
            case false:
                VStack {
                    Button {
                        vm.request()
                    } label: {
                        Text("Take Request")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .onAppear { vm.onAppear() }
    }
}

#Preview {
    IdentificationView()
}

final class IdentificationViewModel: ObservableObject {
    @Published var content: String = "content"
    
    private let network = NetworkService()
    
    func onAppear() {
        // на этот экран приходят данные для запроса.
        // когда экран загружается отправляем запрос и проигрываем анимацию пока ждем ответ
    }
    
    func request() {
        content = ""
        
        let image = UIImage.photoPlant
        guard let data = image.pngData() else { return }
        
        let details: [PlantsDetails] = [.taxonomy, .description]
        network.upload(imageData: data, details: details) { [weak self] response in
            
            // ....
            
            DispatchQueue.main.async {
                self?.content = "content"
            }
        }
    }
}
