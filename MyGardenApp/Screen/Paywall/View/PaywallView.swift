//
//  PaywallView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct PaywallView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Paywall")
            Button("Close") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    PaywallView()
}
