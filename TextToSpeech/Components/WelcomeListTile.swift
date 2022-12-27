//
//  WelcomeListTile.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI

struct WelcomeListTile<Icon: View>: View {
    let icon: Icon
    let title: String
    let subtitle: String
    
    
    
    var body: some View {
        HStack {
            icon
                .frame(width: 120)
                .font(.system(size: 50))
                
            
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(width: 300)
        }
        .padding()
    }
}

struct WelcomeListTile_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeListTile(icon: Image(systemName: "waveform"), title: "Hello", subtitle: "Worldsadiasjdoasjdoasijdioasjdoiasjdiosaj")
    }
}
