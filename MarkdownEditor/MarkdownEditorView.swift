//
//  MarkdownEditorView.swift
//  MarkdownEditor
//
//  Created by Nicole Go on 2025-01-07.
//

import SwiftUI
import Ink
import UniformTypeIdentifiers

struct MarkdownEditorView: View {
    @State var markdown_text: String =
        """
            # Hello, world!
            Feel free to type text here!
        """
    // for prompting exporting dialog
    @State private var isExporting: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Button("Export") {
                    isExporting = true
                    markdown_text += "exporting..."
                }.padding(5)
                TextEditor(text: $markdown_text)
                    .onAppear{
                        markdown_text = loadMarkdown()
                        saveMarkdown(markdown_text)
                    }
                    .onChange(of: markdown_text, initial: true){
                        (oldValue, newValue) in saveMarkdown(newValue)
                    }
                    .padding()
                    .border(Color.gray.opacity(0.3), width: 1)
                    .frame(minHeight: 200)
                
                let parser = MarkdownParser()
                MarkdownPreview(htmlContent: parser.html(from: markdown_text))
            }.border(Color.gray.opacity(0.3), width: 1)
        }.fileExporter (
            isPresented: $isExporting,
            document: MarkdownDocument(markdown: markdownText),
            contentType: .plainText,
            defaultFilename: "MyMarkdown",
        ){
            
        }
    }
    
    func loadMarkdown() -> String {
        // save document path here
        guard let docURL = getDocumentsDirectory()?.appendingPathComponent("MyMarkdown.md") else
            {  return "" }
        
        if FileManager.default.fileExists(atPath: docURL.path) {
            do {
                // try to read the file
                return try String(contentsOf: docURL, encoding: .utf8)
            } catch {
                print("Error reading markdown: \(error.localizedDescription)")
            }
        }
        return ""
    }
    
    func saveMarkdown(_ text: String) {
            guard let docURL = getDocumentsDirectory()?.appendingPathComponent("MyMarkdown.md") else {      return
                }
        
            do {
                try text.write(to: docURL, atomically: true, encoding: .utf8)
                print("Save to \(docURL)")
            } catch {
                print("Error saving markdown: \(error.localizedDescription)")
            }
    }
    
    // helper function to find documents directory
    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}

#Preview {
    MarkdownEditorView()
}
