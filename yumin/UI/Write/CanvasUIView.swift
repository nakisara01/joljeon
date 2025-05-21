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
        let image = exportAsImageWithWhiteBackgroundAndBlackDrawing()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    func exportAsImageWithWhiteBackgroundAndBlackDrawing() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        let renderer = UIGraphicsImageRenderer(size: bounds.size, format: format)

        return renderer.image { context in
            // 흰 배경
            UIColor.white.setFill()
            context.fill(bounds)

            // 검정 드로잉 적용 (이미지로 변환하여 그리기)
            let blackDrawing = PKDrawing(strokes: drawing.strokes.map { stroke in
                PKStroke(
                    ink: PKInk(.pen, color: .black),
                    path: stroke.path,
                    transform: stroke.transform,
                    mask: stroke.mask
                )
            })

            let drawingImage = blackDrawing.image(from: bounds, scale: UIScreen.main.scale)
            drawingImage.draw(in: bounds)
        }
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
