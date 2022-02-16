import Foundation
import SoundAnalysis

class ResultObserver: NSObject, SNResultsObserving, ObservableObject {
    @Published var label = "?"
     
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult,
              let classification = result.classifications.first else { return }

        let confidence = classification.confidence * 100.0
        if confidence > 90 {
            DispatchQueue.main.async {
                self.label = classification.identifier
            }
            print(classification.identifier+" (\(classification.confidence))")
        } else {
            print ("low confidence \(classification.confidence)")
        }
    }
}
