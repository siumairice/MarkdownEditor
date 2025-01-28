//
//  File.swift
//  MarkdownEditor
//
//  Created by Nicole Go on 2025-01-10.
//

import SwiftUI

struct MarkdownPreview: View {
    let htmlContent : String
    let css = """
    <style>
    body {
        font-family: -apple-system, "Helvetica Neue", Helvetica, Arial, sans-serif;
        font-size: 2rem;
        color: #333333;
    }
    </style>
    """
    
    init(htmlContent: String) {
        self.htmlContent = htmlContent
    }
    var body : some View {
        WebView(html: css + htmlContent)
            .padding()
    }
}
