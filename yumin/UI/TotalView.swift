//
//  TabView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct TotalView: View {
    @State private var selectedIndex: Int = 1
    @State private var showSplash = true
    @State private var splashOffsetY: CGFloat = -UIScreen.main.bounds.height
    @StateObject private var drawingModel = DrawingModel()
    
    // State variable to control the presentation of the detail view from anywhere
    @State private var selectedDrawing: IdentifiableDrawing? = nil

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ZStack {
                    VStack(spacing: 0) {
                        // 본문 뷰 (탭 선택에 따라 변경)
                        ZStack {
                            switch selectedIndex {
                            case 1: IntroduceView()
                            case 2: WriteView(detailDrawingIndex: $selectedDrawing, selectedIndex: $selectedIndex)
                            case 3: LibraryView()
                            default: EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        
                        // 커스텀 탭바 (하단 고정)
                        ZStack(alignment: .topLeading) {
                            LeftTopRoundedShape()
                                .fill(Color.white)
                                .frame(height: 100)
                                .fixedSize(horizontal: false, vertical: true)
                                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: -2)
                            
                            HStack(spacing: 40) {
                                Spacer()
                                TabBarIcon(icon: "archivebox", index: 0, selectedIndex: $selectedIndex, showSplash: $showSplash, splashOffsetY: $splashOffsetY)
                                Spacer()
                                TabBarIcon(icon: "star.fill", index: 1, selectedIndex: $selectedIndex, showSplash: $showSplash, splashOffsetY: $splashOffsetY)
                                Spacer()
                                TabBarIcon(icon: "pencil", index: 2, selectedIndex: $selectedIndex, showSplash: $showSplash, splashOffsetY: $splashOffsetY)
                                Spacer()
                                
                                TabBarIcon(icon: "books.vertical", index: 3, selectedIndex: $selectedIndex, showSplash: $showSplash, splashOffsetY: $splashOffsetY)
                                Spacer()
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 10)
                        }
                    }
                    .ignoresSafeArea(edges: .bottom)
                    if showSplash {
                        SplashView(offsetY: $splashOffsetY, showSplash: $showSplash)
                        
                            .onAppear {
                                withAnimation {
                                    splashOffsetY = 0
                                }
                            }
                    }
                }
            }
            .environmentObject(drawingModel)
            // Present DrawingDetailView as a full screen cover when selectedDrawing is not nil
            .fullScreenCover(item: $selectedDrawing) { identifiableDrawing in // Use .fullScreenCover(item:) instead of .sheet(item:)
                 // Use the image and index from the IdentifiableDrawing object
                 DrawingDetailView(drawingImage: identifiableDrawing.image, drawingIndex: identifiableDrawing.index)
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}

struct LeftTopRoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: CGFloat = 0

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + radius, y: rect.minY),
            control: CGPoint(x: rect.minX, y: rect.minY)
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

struct TabBarIcon: View {
    let icon: String
    let index: Int
    @Binding var selectedIndex: Int
    @Binding var showSplash: Bool
    @Binding var splashOffsetY: CGFloat

    var body: some View {
        Button(action: {
            if index == 0 {
                splashOffsetY = -UIScreen.main.bounds.height
                showSplash = true
                selectedIndex = 1
            } else {
                selectedIndex = index
            }
        }) {
            Image(systemName: icon)
                .font(.system(size: 36))
                .foregroundColor(selectedIndex == index ? .green : .gray)
        }
    }
}

#Preview {
    TotalView()
}
