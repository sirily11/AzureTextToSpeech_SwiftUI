//
//  SetupPage.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI

struct SetupPage: View {
    @State var showAuthentication: Bool = false
    
    var body: some View {
        VStack {
            if showAuthentication {
                AuthenticationPage()
            } else {
                WelcomePage(showAuthentication: $showAuthentication)
                    .padding()
            }
        }
    }
}
//
//struct SetupPage_Previews: PreviewProvider {
//    static var previews: some View {
//        SetupPage()
//    }
//}
