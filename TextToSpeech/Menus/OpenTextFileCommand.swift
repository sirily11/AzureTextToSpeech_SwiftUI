//
//  OpenTextFileCommand.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import Foundation
import SwiftUI

enum OpenFileError {
    case fileCannotBeRead
}

extension OpenFileError: LocalizedError {
    var errorDescription: String? {
        switch (self) {
            case .fileCannotBeRead:
                return "File cannot be read"
        }
    }
    
}

struct OpenTextFileCommand: Commands {
    let textModel: TextModel
    let errorModel: ErrorModel
    
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("Open text file") {
               openFile()
            }
        }
    }
    
    func openFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.allowedContentTypes = [.plainText]
        panel.canChooseDirectories = false
        if panel.runModal() == .OK {
            if let url = panel.url {
                do {
                    let data = try Data(contentsOf: url)
                    guard let text = String(data: data, encoding: .utf8) else {
                        throw OpenFileError.fileCannotBeRead
                    }
                    textModel.text = text
                    
                } catch {
                    errorModel.error = error
                }
            }
        }
    }
}
