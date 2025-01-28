//
//  WebView.swift
//  MarkdownEditor
//
//  Created by Nicole Go on 2025-01-10.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let html: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}
