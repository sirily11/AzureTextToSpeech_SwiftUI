//
//  GenerationPage.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI
import AzureTextToSpeech

struct GenerationPage: View {
    @EnvironmentObject var azureModel: AzureTextToSpeech
    @EnvironmentObject var authenticationModel: AuthenticationModel
    @EnvironmentObject var errorModel: ErrorModel
    @EnvironmentObject var generationJobModel: GenerationJobModel
    
    @State var selectedVoice: AzureVoice = .defaultValue

    
    
    var body: some View {
        NavigationSplitView(sidebar: {
            
        }, content: {
            GenerationView()
                .padding()
        }, detail: {
            VoiceSettingsView()
                .frame(minWidth: VoiceSettingsPageWidth)
                .padding()
                .toolbar {
                    if let job = generationJobModel.job {
                        ToolbarItem(placement: .primaryAction) {
                            GenerationJobView(generationJob: job)
                        }
                    }
                }
        })
        .task {
            await initialize()
        }
        .errorAlert(error: $errorModel.error)
        .navigationTitle("Speech To Text")
    }
    
    func initialize() async {
        do {
            guard let key = authenticationModel.key else {
                return
            }
            
            guard let region = authenticationModel.region else {
                return
            }
            try await azureModel.authorize(resourceKey: key, region: region)
            _ = try await azureModel.getListOfVoices()
        } catch {
            errorModel.error = error
        }
    }
}
//
//struct GenerationPage_Previews: PreviewProvider {
//    static var previews: some View {
//        GenerationPage()
//    }
//}
