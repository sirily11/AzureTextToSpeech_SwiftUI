//
//  MusicPlayerPage.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/27/22.
//

import SwiftUI
import AVKit

struct MusicPlayerPage: View {
    let url: URL
    
    @State var audioPlayer: AVAudioPlayer? = nil
    @State var currentTime: Double = 10
    @State var totalTime: Double = 20
    @State var isPlaying = false
    @State var onHover = false
    @State var isChangingSlider = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let currentTimeString = currentTime.asTimeString(style: .positional)
        let totalTimeString = totalTime.asTimeString(style: .positional)
        
        NavigationStack {
            VStack {
                HStack {
                    Text(currentTimeString)
                    Spacer()
                    Text(totalTimeString)
                }
                .padding(.horizontal, 8)
                
                Slider(value: $currentTime, in: 0...totalTime) { changed in
                    if !changed {
                        seekTime()
                    }
                    isChangingSlider = changed
                }
                .disabled(audioPlayer == nil)
                
                if onHover {
                    HStack {
                        Spacer()
                        Button(action: {
                            backward()
                        }) {
                            Image(systemName: "backward.fill")
                                .font(.title)
                            
                        }
                        .disabled(audioPlayer == nil)
                        .buttonStyle(.borderless)
                        
                        Button(action: {
                            if isPlaying {
                                stop()
                            } else {
                                play()
                            }
                        }) {
                            Group {
                                if isPlaying {
                                    Image(systemName: "stop.fill")
                                } else {
                                    Image(systemName: "play.fill")
                                }
                            }
                            .font(.largeTitle)
                            
                        }
                        .buttonStyle(.borderless)
                        .disabled(audioPlayer == nil)
                        
                        Button(action: {
                            forward()
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.title)
                        }
                        .buttonStyle(.borderless)
                        .disabled(audioPlayer == nil)
                        
                        Spacer()
                    }
                    .frame(height: 20)
                } else {
                    VStack {
                        Text(url.lastPathComponent)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(url.absoluteString)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .frame(height: 20)
                }
            }
            .padding()
            .animation(.easeOut, value: onHover)
            .onHover(perform: { value in
                withAnimation{
                    onHover = value
                }
            })
            .onAppear {
                initialize()
            }
            .frame(width: MusicPlayerPageWidth, height: MusicPlayerPageHeight)
            .onReceive(timer) { _ in
                if !isChangingSlider {
                    updateCurrentTime()
                }
            }
            .navigationTitle("Music player \(url.lastPathComponent)")
        }
    }
    
    func backward() {
        audioPlayer?.currentTime = max(0, currentTime - 3)
    }
    
    func forward() {
        audioPlayer?.currentTime = min(totalTime, currentTime + 3)
    }
    
    func initialize() {
        if let audioPlayer =  try? AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue) {
            self.audioPlayer = audioPlayer
            totalTime = audioPlayer.duration
            isPlaying = audioPlayer.isPlaying
        }
    }
    
    func updateCurrentTime() {
        if let player = audioPlayer {
            currentTime = player.currentTime
            isPlaying = player.isPlaying
        }
    }
    
    func stop() {
        audioPlayer?.stop()
        isPlaying = false
    }
    
    func play() {
        audioPlayer?.play()
        isPlaying = true
    }
    
    func seekTime() {
        audioPlayer?.currentTime = currentTime
    }
}

struct MusicPlayerPage_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerPage(url: URL(string: "https://pub-37a096d288074149a469e20bf3e489b8.r2.dev/demo.wav")!)
    }
}
