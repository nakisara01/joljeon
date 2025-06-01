import Foundation
import SwiftUI

class DrawingModel: ObservableObject {
    @Published var savedDrawings: [UIImage] = []
    private let saveKey = "savedDrawings"
    
    init() {
        loadDrawings()
    }
    
    func saveDrawing(_ image: UIImage) {
        savedDrawings.append(image)
        saveToUserDefaults()
    }
    
    // Add a method to save changes after deletion or modification
    func saveChanges() {
        saveToUserDefaults()
    }
    
    private func saveToUserDefaults() {
        let imageDataArray = savedDrawings.compactMap { image -> Data? in
            return image.jpegData(compressionQuality: 0.8)
        }
        UserDefaults.standard.set(imageDataArray, forKey: saveKey)
    }
    
    public func loadDrawings() {
        guard let imageDataArray = UserDefaults.standard.array(forKey: saveKey) as? [Data] else { return }
        savedDrawings = imageDataArray.compactMap { data in
            UIImage(data: data)
        }
    }
    
    // Add a method to get the index of the last saved drawing
    func lastDrawingIndex() -> Int? {
        return savedDrawings.isEmpty ? nil : savedDrawings.count - 1
    }
}

// Helper struct to make a drawing and its index identifiable
struct IdentifiableDrawing: Identifiable {
    let id = UUID() // Unique identifier
    let image: UIImage
    let index: Int
} 