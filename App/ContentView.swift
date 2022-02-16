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


struct ContentView: View {
    @ObservedObject var resultsObserver = ResultObserver()
    @State private var state = "Not recording"
    @State private var is_recording = false
    
    var body: some View {
        Button(state, action: {
            connectivity.sendMessage(message: [String : Any]())
            if is_recording {
                self.stopCapturingAudio()
            } else {
                self.startCapturingAudio()
            }
            is_recording = !is_recording
        }).padding()
    }
    
    init() {
        connectivity.connect()
        inputFormat = engine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
    }
    
    private func startCapturingAudio()
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
        
        //Set registration audio requedt parameter
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
        resultsObserver.label = "?"
    }
    
    private func notify() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
