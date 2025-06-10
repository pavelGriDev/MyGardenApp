//
//  String+ext.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 10.06.25.
//

import Foundation

extension String {
    func toData() -> Data? {
        self.data(using: .utf8)
    }
}
