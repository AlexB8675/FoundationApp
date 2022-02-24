//
//  ContentView.swift
//  App"
//
//  Created by Sara Izzo on 16/02/22.
//

import SwiftUI
import AVKit
import SoundAnalysis
import Speech
import Foundation

let classifier = try! Classifier()
let engine = AVAudioEngine()
var inputFormat: AVAudioFormat!
var analyzer: SNAudioStreamAnalyzer!
let analysisQueue = DispatchQueue(label: "com.apple.AnalysisQueue")
var connectivity = ConnectivityProvider()

struct ContentView: View {
    @ObservedObject var resultsObserver = ResultObserver()
    @State private var state = "Not recording"
    @State public var is_recording = false
    @State private var micImage = "mic.slash.fill"
    @State private var textLabel = "Tap to begin listening"
    
    var body: some View {
        ZStack {
            
            Image("Sfondo")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                Text(textLabel)
                
                Button(action: {
                    if is_recording {
                        self.stopCapturingAudio()
                        micImage = "mic.slash.fill"
                        textLabel = "Tap to begin listening"
                    } else {
                        self.startCapturingAudio()
                        micImage = "mic.fill"
                        textLabel = "Tap to stop listening"
                    }
                    is_recording = !is_recording
                }, label: {
                    Image(systemName: micImage)
                        .font(.system(size: 60))
                }).padding()
                
                Text(state)
                    
                Text(resultsObserver.label)
                
            }
            .navigationBarTitle("NomeApp")

        }
        .foregroundColor(.white)
    }
        
    init() {
        inputFormat = engine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        connectivity.connect()
    }
    
    public func startCapturingAudio()
    {
        // Inizializza il microfono
        do
        {
            engine.prepare()
            try engine.start()
        }
        catch
        {
            print("Failed to start your AV engine")
            return
        }
        
        
        
        do
        {
            let request = try SNClassifySoundRequest(mlModel: classifier.model)
            try analyzer.add(request, withObserver: resultsObserver) //observer registration
            print("Request appended")
        }
        catch
        {
            print("Unable to prepare request: \(error.localizedDescription)")
            return
        }
        
        //Set registration audio request parameter
        engine.inputNode.installTap(onBus: 0, bufferSize: 16384, format: inputFormat)
        { buffer, time in
            //closure
            let channelDataValue = buffer.floatChannelData!.pointee
            let channelDataValueArray = stride(from: 0,
                                               to: Int(buffer.frameLength),
                                               by: buffer.stride).map{ channelDataValue[$0] }
            
            let vArray = channelDataValueArray.map{ $0 * $0 }
            let rArray = vArray.reduce(0, +)
            let rms = sqrt(rArray / Float(buffer.frameLength))
            
            let avgPower = 20 * log10(rms)
            if avgPower > -50.0
            {
                analysisQueue.async
                {
                    analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
                }
            }
        }//end closure
        state = "Listening"
        
    }//end function
    
    private func stopCapturingAudio()
    {
        //add stop button
        engine.inputNode.removeTap(onBus: 0)
        state = "Stopped listening!"
        resultsObserver.label = " "
    }
    
    private func notify() {
        
    }
}
