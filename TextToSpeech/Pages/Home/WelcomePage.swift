//
//  WelcomePage.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI

enum SettingsRoute: Hashable {
    case detail
}

struct WelcomePage: View {
    @Binding var showAuthentication: Bool
    
    var body: some View {
        VStack {
            LogoView()
            WelcomeListTile(icon: Image(systemName: "arrow.up"), title: "Increased efficiency", subtitle: "AI TTS technology can save time and effort by automatically converting written text into speech, allowing users to listen to content rather than read it.")
            WelcomeListTile(icon: Image(systemName: "globe"), title: "Language support", subtitle: "AI TTS technology can support multiple languages, making it easier for users to access content in their preferred language.")
            WelcomeListTile(icon: Image(systemName: "rectangle.and.pencil.and.ellipsis"), title: "Automation", subtitle: "AI TTS technology can be used to automate the process of generating audio versions of written content, allowing businesses to save time and resources.")
            
            Button("Continue") {
                showAuthentication = true
            }
        }
        .frame(height: WelcomePageHeight)
    }
}
//
//struct WelcomePage_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomePage(showAuthentication: .constant(false))
//    }
//}
