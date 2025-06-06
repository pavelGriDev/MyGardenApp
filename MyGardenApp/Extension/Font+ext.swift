//
//  Font+ext.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 06.06.25.
//

import SwiftUI

enum AppFont: String {
    case regular = "Onest-Regular"
    case semiBold = "Onest-SemiBold"
}

extension Font {
    static func customFont(_ font: AppFont, size: CGFloat) -> Font {
        Font.custom(font.rawValue, fixedSize: size)
    }
}
