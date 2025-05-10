//
//  SplashView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("IntroduceBackground")
                .resizable()
                .ignoresSafeArea()
            

            Text("Hello, World!")
        }
    }
}

#Preview {
    SplashView()
}
