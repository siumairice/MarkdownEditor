//
//  MarkdownDocument.swift
//  MarkdownEditor
//
//  Created by Nicole Go on 2025-01-10.
//

import SwiftUI
import UniformTypeIdentifiers

struct MarkdownDocument: FileDocument {
    // .markdown is now supported as well!!!
    static var readableContentTypes = [UTType.plainText] // types of readable files
    
    // takes in a string "markdown"
    var markdown: String
    
    init(markdown: String = "") {
        self.markdown = markdown
    }
    
    // initializer for reading files from memory
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let content = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.markdown = content
    }
    
    // converts string to utf8 data
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = markdown.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
    
    
}
