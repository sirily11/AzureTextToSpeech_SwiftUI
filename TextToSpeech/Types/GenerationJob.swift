//
//  VoiceJob.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/27/22.
//

import Foundation

struct GenerationJob: Codable {
    var outputUrl: URL?
    var downloaded: Int64?
    var isFinished = false
}
