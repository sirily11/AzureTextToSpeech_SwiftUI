//
//  GenerationJobModel.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/27/22.
//

import Foundation



class GenerationJobModel: ObservableObject {
    @Published var job: GenerationJob?
    
    @MainActor
    func start(){
        job = GenerationJob()
    }

    @MainActor
    func updateDownloadedSize(fileSize: Int64) {
        job?.downloaded = fileSize
    }
    
    @MainActor
    func updateOutputUrl(url: URL) {
        job?.outputUrl = url
    }
    
    @MainActor
    func finish() {
        job?.isFinished = true
    }
}
