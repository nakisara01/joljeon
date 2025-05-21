//
//  TabView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct TotalView: View {
    @State private var selectedIndex: Int = 2

    var body: some View {
        ZStack {

            VStack(spacing: 0) {
                // 본문 뷰 (탭 선택에 따라 변경)
                ZStack {
                    switch selectedIndex {
                    case 0: SplashView()
                    case 1: IntroduceView()
                    case 2: WriteView()
                    case 3: LibraryView()
                    default: SplashView()
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
                        TabBarIcon(icon: "archivebox", index: 0, selectedIndex: $selectedIndex)
                        Spacer()
                        TabBarIcon(icon: "star.fill", index: 1, selectedIndex: $selectedIndex)
                        Spacer()
                        TabBarIcon(icon: "pencil", index: 2, selectedIndex: $selectedIndex)
                        Spacer()
                        TabBarIcon(icon: "books.vertical", index: 3, selectedIndex: $selectedIndex)
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                }
            }
            .ignoresSafeArea(edges: .bottom)
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

    var body: some View {
        Button(action: {
            selectedIndex = index
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
