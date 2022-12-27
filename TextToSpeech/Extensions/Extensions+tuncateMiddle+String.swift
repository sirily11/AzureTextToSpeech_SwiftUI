//
//  Extensions+tuncateMiddle+String.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/27/22.
//

import Foundation
import NaturalLanguage

extension String {
    func truncateMiddle() -> String {
        let startIndex = self.startIndex
        let endIndex = self.endIndex
        if self.count <= 13 {
            return self
        }
        let firstFive = self[startIndex..<self.index(startIndex, offsetBy: 5)]
        let lastFive = self[self.index(endIndex, offsetBy: -5)..<endIndex]
        return "\(firstFive)...\(lastFive)"
    }
}
