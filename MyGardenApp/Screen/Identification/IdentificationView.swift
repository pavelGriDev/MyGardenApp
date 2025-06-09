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
        switch vm.content.isEmpty {
        case true:
            LoadingView()
        case false:
            EmptyView()
        }
    }
}

#Preview {
    IdentificationView()
}

final class IdentificationViewModel: ObservableObject {
    @Published var content: String = ""
    
    func onAppear() {
        
    }
}
