
import SwiftUI

class TextRecognizer: ObservableObject {
    
    @Published private var classifier = Recognizer()
    
    
    var recognizedStrings: [String]? {
        classifier.results
    }
        
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else { return }
        classifier.detect(cgImage: cgImage)
    
    }
        
}
