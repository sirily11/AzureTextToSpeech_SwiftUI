//
//  AuthenticationPage.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI
import AzureTextToSpeech

struct AuthenticationPage: View {
    @State var resourceKey: String = ""
    @State var region: AzureRegion = .eastAsia
    @State var error: Error? = nil
    
    @EnvironmentObject var authenticationModel: AuthenticationModel
    @EnvironmentObject var azureModel: AzureTextToSpeech
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            LogoView()
            Form {
                Section("Azure credentials") {
                    if let error = error {
                        Text(error.localizedDescription).foregroundColor(.red)
                    }
                    TextField("Resource Key", text: $resourceKey)
                    Picker("Azure Region", selection: $region) {
                        ForEach(AzureRegion.allCases) { region in
                            Text(region.rawValue).tag(region)
                        }
                    }
                }
               
                HStack {
                    Button("Close") {
                        dismiss()
                    }
                    .disabled(authenticationModel.isLoading)
                    
                    Button {
                        Task {
                            await save()
                        }
                    } label: {
                        if authenticationModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Save")
                        }
                    }
                    .disabled(authenticationModel.isLoading)

                }
                .formStyle(.columns)
            }
        }
        .task {
            initialize()
        }
        .frame(width: WelcomePageWidth, height: WelcomePageHeight)
        .fixedSize()
    }
    
    func initialize() {
        resourceKey = authenticationModel.key ?? ""
        region = authenticationModel.region ?? .eastAsia
    }
    
    func save() async {
        error = nil
        authenticationModel.isLoading = true
        do {
            try await azureModel.authorize(resourceKey: resourceKey, region: region)
            authenticationModel.save(key: resourceKey, region: region)
        } catch {
            self.error = error
        }
        authenticationModel.isLoading = false
    }
}
//
//struct AuthenticationPage_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticationPage()
//            .environmentObject(AuthenticationModel())
//    }
//}
