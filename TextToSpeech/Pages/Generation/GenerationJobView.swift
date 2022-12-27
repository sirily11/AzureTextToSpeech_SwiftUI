//
//  GenerationJobView.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/27/22.
//

import SwiftUI

struct GenerationJobView: View {
    let generationJob: GenerationJob
    
    
    var body: some View {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = .useMB
        
        return Tooltip {
            VStack(alignment: .leading) {
                Text(generationJob.outputUrl?.lastPathComponent ?? "")
                Text("Downloaded: \(formatter.string(fromByteCount: generationJob.downloaded ?? 0))")
            }.padding()
        } content: {
            Group {
                if generationJob.isFinished {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.largeTitle)
                } else {
                    ProgressView()
                }
            }
        }
    }
}
