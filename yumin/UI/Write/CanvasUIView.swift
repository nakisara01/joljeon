//
//  CanvasUIView.swift
//  yumin
//
//  Created by 나현흠 on 5/11/25.
//

import PencilKit
import UIKit

class CanvasUIView: PKCanvasView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.drawingPolicy = .anyInput
    }

    func clearDrawing() {
        self.drawing = PKDrawing()
    }
    
    func saveImageToPhotoLibrary() {
        let image = exportAsImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    func exportAsImage() -> UIImage {
        let image = UIGraphicsImageRenderer(bounds: bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }

    func setTool(_ tool: PKTool) {
        self.tool = tool
    }
}
