//
//  TextToSpeechApp.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI
import SwiftUIKit
import AzureTextToSpeech

@main
struct TextToSpeechApp: App {
    @StateObject var authenticationModel: AuthenticationModel = AuthenticationModel()
    @StateObject var sheetContext = SheetContext()
    @StateObject var azureModel = AzureTextToSpeech()
    @StateObject var textModel = TextModel()
    @StateObject var errorModel = ErrorModel()
    @StateObject var generationJobModel = GenerationJobModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(authenticationModel)
                .environmentObject(sheetContext)
                .environmentObject(azureModel)
                .environmentObject(textModel)
                .environmentObject(errorModel)
                .environmentObject(generationJobModel)
        }
        .commands {
            OpenTextFileCommand(textModel: textModel, errorModel: errorModel)
            SignoutCommand(authenticationModel: authenticationModel, errorModel: errorModel)
        }
        
        WindowGroup("Music player", for: URL.self) { url in
            if let url = url.wrappedValue {
                MusicPlayerPage(url: url)
            }
        }
        .windowResizability(.contentSize)
        
    }
}
