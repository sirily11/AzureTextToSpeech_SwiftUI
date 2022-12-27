//
//  ContentView.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI
import SwiftUIKit
import AzureTextToSpeech

struct HomeView: View {
    @EnvironmentObject var authenticationModel: AuthenticationModel
    @EnvironmentObject var azureModel: AzureTextToSpeech
    @EnvironmentObject var sheetContext: SheetContext
    
    var body: some View {
        Group {
            if authenticationModel.isAuthenticated {
                GenerationPage()
            } else {
              SetupPage()
            }
        }
        .task {
            await onInit()
        }
    }
    
    func onInit() async {

    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
