//
//  CanvasView.swift
//  yumin
//
//  Created by 나현흠 on 5/11/25.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: CanvasUIView

    func makeUIView(context: Context) -> CanvasUIView {
        return canvasView
    }

    func updateUIView(_ uiView: CanvasUIView, context: Context) {}
}
