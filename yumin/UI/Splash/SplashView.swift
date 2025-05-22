//
//  SplashView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct SplashView: View {
    //TODO: 좀더 매끄럽게 제스쳐 구현하는 법 연구 & 스크롤 했을 때 IntroduceView 내용이 움직이지 않도록 조절하는 법
    @GestureState private var dragOffset = CGSize.zero
    @Binding var offsetY: CGFloat
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            Image("SplashViewBackground")
                .resizable()
                .scaledToFill()
                .offset(y: offsetY + dragOffset.height)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            if value.translation.height < 0 {
                                state = value.translation
                            }
                        }
                        .onEnded { value in
                            if value.translation.height < -500 {
                                offsetY = -UIScreen.main.bounds.height
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    showSplash = false
                                }
                            }
                        }
                )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TotalView()
}
