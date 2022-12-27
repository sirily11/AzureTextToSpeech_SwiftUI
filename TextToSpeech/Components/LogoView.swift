//
//  LogoView.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "waveform")
                    .font(.system(size: 100))
                    .foregroundColor(.purple)
                Spacer()
            }
            
            Text("Welcome to")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Text to speech")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
