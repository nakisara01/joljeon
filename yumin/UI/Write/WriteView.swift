//
//  WriteView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI
import PencilKit

struct WriteView: View {
    @State private var canvasView = PKCanvasView()

    var body: some View {
        ZStack{
            Image("IntroduceBackground")
                .resizable()
                .ignoresSafeArea()
            VStack {
                CanvasView(canvasView: $canvasView)
                    .frame(height: 800)
                    .frame(width: 700)
                    .clipShape(RoundedRectangle(cornerRadius: 20))  // 모양 자르기
                    .overlay(                                      // 라운드 테두리 추가
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Button("Clear") {
                    canvasView.drawing = PKDrawing()
                }
                .padding()
            }
            .onAppear {
                let tool = PKInkingTool(.pen, color: .black, width: 5)
                canvasView.tool = tool
            }
        }
    }
}

// UIViewRepresentable로 PKCanvasView를 SwiftUI에 연결
struct CanvasView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.layer.cornerRadius = 20  // 원하는 값으로 설정
            canvasView.clipsToBounds = true     // 라운딩 적용을 위해 필요
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

#Preview {
    WriteView()
}
