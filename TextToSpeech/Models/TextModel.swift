//
//  TextModel.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import Foundation

class TextModel: ObservableObject {
    @Published var text: String = ""
    
    func updateText(newText: String) {
        self.text = text
    }
}
