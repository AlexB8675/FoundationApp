//
//  ResultObserver.swift
//  App"
//
//  Created by Sara Izzo on 16/02/22.
//

import Foundation
import SoundAnalysis
import SwiftUI

/**
 * Class that conforms to the SNResultsObserving protocol, and ObservableObject
 */



class ResultObserver: NSObject, SNResultsObserving, ObservableObject
{
    @Published var label = " "
     
    func request(_ request: SNRequest, didProduce result: SNResult)
    {
        guard let result = result as? SNClassificationResult,
            let classification = result.classifications.first else { return }

        let confidence = classification.confidence * 100.0
        if confidence > 90
        {

            DispatchQueue.main.async
            {
                self.label = classification.identifier
                connectivity.label = classification.identifier
                if classification.identifier == "Pianto" {
                    connectivity.sendMessage(message: [:])
                }
            }
            
            print(classification.identifier+" (\(classification.confidence))")
        }
        else
        {
            print ("low confidence \(classification.confidence)")
        }
    }
}
