//
//  WriteView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI
import PencilKit

struct WriteView: View {
    @State private var canvasView = CanvasUIView()
    @EnvironmentObject var drawingModel: DrawingModel
    
    // Binding to the selectedDrawing in TotalView (now IdentifiableDrawing?)
    @Binding var detailDrawingIndex: IdentifiableDrawing?
    
    // Binding to the selectedIndex in TotalView
    @Binding var selectedIndex: Int

    var body: some View {
        ZStack{
            Image("WriteViewBackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack(spacing: 80){
                    Button(action: {
                        canvasView.clearDrawing()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 36))
                            .foregroundStyle(Color.white)
                    }
                    
                    Button(action: {
                        var drawing = canvasView.drawing
                            if !drawing.strokes.isEmpty {
                                drawing.strokes.removeLast()
                                canvasView.drawing = drawing
                            }
                    }){
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 36))
                            .foregroundStyle(Color.white)
                    }
                    Button(action: {
                        let image = canvasView.exportAsImageWithWhiteBackgroundAndBlackDrawing()
                        canvasView.saveImageToPhotoLibrary()
                        drawingModel.saveDrawing(image)
                        
                        // Get the index of the last saved drawing and create an IdentifiableDrawing object
                        if let lastIndex = drawingModel.lastDrawingIndex() {
                            // Ensure the image is available before creating IdentifiableDrawing
                            if let lastDrawingImage = drawingModel.savedDrawings.last { // Get the image by index if needed
                                detailDrawingIndex = IdentifiableDrawing(image: lastDrawingImage, index: lastIndex) // Set the binding with IdentifiableDrawing
                            }
                        }
                        
                        // Set selectedIndex to 3 to navigate to LibraryView
                        selectedIndex = 3
                    }){
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 36))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.vertical)
                .padding(.top, 160)
                CanvasView(canvasView: $canvasView)
                    .frame(height: 800)
                    .frame(width: 800)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
                    .padding(.top, 40)
            }
            .onAppear {
                let tool = PKInkingTool(.pen, color: .white, width: 5)
                canvasView.setTool(tool)
            }
        }
    }
}

#Preview {
    TotalView()
}
