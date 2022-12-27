//
//  VoiceSettingsView.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI
import AzureTextToSpeech

struct VoiceSettingsView: View {
    @EnvironmentObject var azureModel: AzureTextToSpeech
    @EnvironmentObject var authenticationModel: AuthenticationModel
    @EnvironmentObject var generationJobModel: GenerationJobModel
    
    @AppStorage("voice") var selectedVoice: AzureVoice = .defaultValue
    @AppStorage("locale") var selectedLocale: String = ""
    @AppStorage("voiceType") var selectedVoiceType: String = ""
    @AppStorage("gender") var selectedGender: String = ""
    @AppStorage("style") var selectedStyle: String = ""
    @AppStorage("role") var selectedRole: String = ""
    @AppStorage("format") var selectedFormat: AzureAudioFormat = .defaultFormat
    @AppStorage("pitch") var pitch: Double = 0
    @AppStorage("speed") var speed: Double = 1
    
    @Environment(\.openWindow) var openMusicPlayer
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTile(title: "Voice") {
                Picker("Gender", selection: $selectedGender) {
                    ForEach(azureModel.genders, id: \.self) { gender in
                        Text("\(gender)").tag(gender)
                    }
                }
                .disabled(azureModel.isDisabledForSelection)
                
                Picker("Locale", selection: $selectedLocale) {
                    ForEach(azureModel.locales, id: \.self) { locale in
                        Text("\(locale)").tag(locale)
                    }
                }
                .disabled(azureModel.isDisabledForSelection)
                
                Picker("Voice Type", selection: $selectedVoiceType) {
                    ForEach(azureModel.types, id: \.self) { type in
                        Text("\(type)").tag(type)
                    }
                }
                .disabled(azureModel.isDisabledForSelection)
                
                Picker("Voice", selection: $selectedVoice) {
                    if azureModel.voices.count == 0 {
                        Text(selectedVoice.displayName).tag(selectedVoice)
                    }
                    ForEach(azureModel.filteredVoices, id: \.name) { voice in
                        Text("\(voice.displayName) - \(voice.gender) - \(voice.localeName)").tag(voice)
                    }
                }
                .disabled(azureModel.isDisabledForSelection)
            }
            if selectedVoice != .defaultValue {
                SectionTile(title: "Style") {
                    if let styleList =  selectedVoice.styleList {
                        Picker("Style", selection: $selectedStyle) {
                            ForEach(styleList, id: \.self) { type in
                                Text("\(type)").tag(type)
                            }
                        }
                        .disabled(azureModel.isDisabledForSelection)
                    }
                    
                    if let roleList =  selectedVoice.rolePlayList {
                        Picker("Role", selection: $selectedRole) {
                            ForEach(roleList, id: \.self) { type in
                                Text("\(type)").tag(type)
                            }
                        }
                        .disabled(azureModel.isDisabledForSelection)
                    }
                    
                    Slider(value: $pitch, in: 0...3, step: 0.1) {
                        Text("Pitch: \(String(format: "%.2f", pitch))")
                    }
                    
                    Slider(value: $speed, in: 0...2, step: 0.1) {
                        Text("Speed: \(String(format: "%.2f", speed))")
                    }
                }
            }
            SectionTile(title: "Output") {
                Picker("Format", selection: $selectedFormat) {
                    ForEach(AzureAudioFormat.allCases) { format in
                        Text("\(format.rawValue)").tag(format)
                    }
                }
                .disabled(azureModel.isDisabledForSelection)
                Text("Format starts with riff is for non-straming save. Others are for streaming.")
                    .foregroundColor(.gray)
                    .font(.caption)
                if let job = generationJobModel.job, let url = job.outputUrl {
                    Button("Play the output file") {
                        openMusicPlayer(value: url)
                    }
                }
                
            }
            Spacer()
            
        }
        .onChange(of: selectedVoice) { newValue in
            azureModel.pickVoice(voice: newValue)
            selectedStyle = ""
            selectedRole = ""
        }
        .onChange(of: selectedLocale) { newValue in
            azureModel.filter(gender: selectedGender, locale: selectedLocale, voiceType: selectedVoiceType)
        }
        .onChange(of: selectedGender) { newValue in
            azureModel.filter(gender: selectedGender, locale: selectedLocale, voiceType: selectedVoiceType)
        }
        .onChange(of: selectedVoiceType) { newValue in
            azureModel.filter(gender: selectedGender, locale: selectedLocale, voiceType: selectedVoiceType)
        }
        .onChange(of: selectedFormat) { newValue in
            azureModel.pickFormat(format: newValue)
        }
        .task {
            azureModel.pickFormat(format: selectedFormat)
            azureModel.pickVoice(voice: selectedVoice)
            azureModel.filter(gender: selectedGender, locale: selectedLocale, voiceType: selectedVoiceType)
        }
    }
}
//
//struct VoiceSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        VoiceSettingsView()
//    }
//}
