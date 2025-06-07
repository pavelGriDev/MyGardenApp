//
//  View+SettingsAlert.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 07.06.25.
//

import SwiftUI

extension View {
    func openSettingAlert(
        isPresented: Binding<Bool>,
        model: SettingAlert,
        openAction: @escaping () -> Void,
        cancelAction: @escaping () -> Void) -> some View {
        return alert(model.title, isPresented: isPresented, presenting: model) { _ in
            
            Button("Cancel", role: .cancel) { cancelAction() }

            Button("Open Settings") { openAction() }
                .keyboardShortcut(.defaultAction)
        } message: { model in
            Text(model.message)
        }
    }
}
