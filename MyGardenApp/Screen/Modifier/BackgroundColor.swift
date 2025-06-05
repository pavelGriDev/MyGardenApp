//
//  BackgroundColor.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

struct BackgroundColor: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        ZStack {
            color
                .ignoresSafeArea()
            content
        }
    }
   
}

extension View {
    func backgroundColor(_ color: Color = .appBackgroundPrimary) -> some View {
        self
            .modifier(BackgroundColor(color: color))
    }
}
