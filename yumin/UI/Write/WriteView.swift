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

    var body: some View {
        VStack {
            CanvasView(canvasView: $canvasView)
                .frame(height: 800)
                .frame(width: 700)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))

            HStack {
                Button("Clear") {
                    canvasView.clearDrawing()
                }

                Button("Save as Image") {
                    let image: () = canvasView.saveImageToPhotoLibrary()
                }
            }
            .padding()
        }
        .onAppear {
            let tool = PKInkingTool(.pen, color: .black, width: 5)
            canvasView.setTool(tool)
        }
    }
}

#Preview {
    WriteView()
}
