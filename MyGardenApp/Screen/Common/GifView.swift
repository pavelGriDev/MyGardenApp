//
//  GifView.swift
//  MyGardenApp
//
//  Created by Pavel Gritskov on 09.06.25.
//

import SwiftUI
import WebKit

struct GifView: UIViewRepresentable {
    private let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        // force unwrap это осознанный выбор, потому что если локального ресурса нет апка должна упасть.
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent()
        )
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    
    typealias UIViewType = WKWebView
}
