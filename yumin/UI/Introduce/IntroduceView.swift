//
//  IntroduceView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct IntroduceView: View {
    var body: some View {
        ZStack {
            Image("IntroduceViewBackground")
                .resizable()
                .ignoresSafeArea()
            

            Text("Hello, World!")
        }
        VStack{
            Image("IntroduceLabel")
                .padding(.top,80)
            Spacer()
        }
    }
}

#Preview {
    TotalView()
}
