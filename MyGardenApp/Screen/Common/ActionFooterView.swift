//
//  ActionFooterView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import SwiftUI

struct ActionFooterView: View {
    
    let termsAction: () -> Void
    let restoreAction: () -> Void
    let privacyAction: () -> Void
    
    var body: some View {
        HStack {
            ForEach(Buttons.allCases) { button in
                Button {
                    switch button {
                    case .terms:
                        termsAction()
                    case .restore:
                        restoreAction()
                    case .privacy:
                        privacyAction()
                    }
                } label: {
                    Text(button.title)
                        .font(.customFont(.regular, size: 14))
                        .foregroundStyle(Color.textTretiery)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
    }
    
    enum Buttons: CaseIterable, Identifiable {
        case terms
        case restore
        case privacy
        
        var id: Self { self }
        
        var title: String {
            switch self {
            case .terms:
                "Terms of Use"
            case .restore:
                "Restore"
            case .privacy:
                "Privacy Policy"
            }
        }
    }
}
