//
//  View+ext.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 05.06.25.
//

import SwiftUI

extension View {
    /// Disables swipe gestures in `TabView` by blocking `DragGesture` handling.
    func tabViewDisableSwiping() -> some View {
        self
            .gesture(DragGesture().onChanged({ _ in }))
    }
}
