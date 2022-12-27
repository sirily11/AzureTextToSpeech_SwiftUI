//
//  GenerationView.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI
import AzureTextToSpeech

enum SaveFileError: LocalizedError {
    case unableToSave
    
    var errorDescription: String? {
        switch self {
            case .unableToSave:
                return "Unable to save file to the destination"
        }
    }
}

struct GenerationView: View {
    @EnvironmentObject var textModel: TextModel
    @EnvironmentObject var errorModel: ErrorModel
    @EnvironmentObject var azureModel: AzureTextToSpeech
    @EnvironmentObject var generationJobModel: GenerationJobModel
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .cornerRadius(.init(radius: 10))
                .frame(minWidth: 500)
            HStack {
                Spacer()
                Button("Play") {
                    
                }.disabled(true)
                
                Button("Save to file") {
                    Task {
                        await save()
                    }
                }
            }
        }
        .onChange(of: text) { newValue in
            textModel.updateText(newText: newValue)
        }
        .onChange(of: textModel.text) { newValue in
            text = newValue
        }
        .task {
            text = textModel.text
        }
    }
    
    func save() async {
        do {
            let savePanel = NSSavePanel()
            savePanel.nameFieldStringValue = "\(text.truncateMiddle()).wav"
            
            if savePanel.runModal() == .OK {
                guard let url = savePanel.url else {
                    errorModel.error = SaveFileError.unableToSave
                    return
                }
                try await azureModel.generateForDownload(text: text, destination: url, onStart: {
                    generationJobModel.start()
                    generationJobModel.updateOutputUrl(url: url)
                }, onDownload: { downloaded in
                    generationJobModel.updateDownloadedSize(fileSize: downloaded)
                })
                generationJobModel.finish()
            }
        } catch {
            errorModel.error = error
        }
    }
}

struct GenerationView_Previews: PreviewProvider {
    static var previews: some View {
        GenerationView()
            .environmentObject(TextModel())
            .environmentObject(ErrorModel())
            .environmentObject(AzureTextToSpeech())
            .environmentObject(GenerationJobModel())
    }
}
