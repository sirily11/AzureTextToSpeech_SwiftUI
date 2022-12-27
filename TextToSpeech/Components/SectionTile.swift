//
//  SectionTile.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import SwiftUI

struct SectionTile<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            content
            Divider()
        }
    }
}
