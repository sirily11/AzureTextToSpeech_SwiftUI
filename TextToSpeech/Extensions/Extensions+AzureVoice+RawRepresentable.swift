//
//  Extensions+AzureVoice+RawRepresentable.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import Foundation
import AzureTextToSpeech

extension AzureVoice: RawRepresentable {
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
    
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(AzureVoice.self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    
}
