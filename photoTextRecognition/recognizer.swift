
import CoreML
import Vision
import CoreImage
import UIKit

struct Recognizer {
    
    private(set) var results: [String]?
    
    mutating func detect(cgImage: CGImage) {
        
        let request = VNRecognizeTextRequest()
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en-US"]
        request.usesLanguageCorrection = true
        
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        do {
            try handler.perform([request])
        } catch {
            print("Unable to perform the request: \(error).")
        }
        
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
        
        let recognizedStrings = observations.compactMap{observation in
            return observation.topCandidates(1).first?.string
        }

        print("recognized Strings \(recognizedStrings)")
        
        let processedString = filterStringByDate(originalStrings: recognizedStrings)
        
        self.results = processedString
        
        
    }
    
    mutating func filterStringByDate(originalStrings: [String]) -> [String] {
        var processedStrings: [String] = []
        
        for str in originalStrings{
            if (str.range(of: #"\d{4}(-|.)(0[1-9]|1[0-2])(-|.)(0[1-9]|[12][0-9]|3[01])"#,
                          options: .regularExpression) != nil){
                processedStrings.append(str)
            }
        }
        return processedStrings
    }
}

