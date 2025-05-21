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
        }
        VStack{
            Image("IntroduceLabel")
                .padding(.top,80)
            Spacer()
            ScrollView{
                Text("hi")
            }
            .frame(height: 800)
            .frame(width: 800)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))

        }
    }
}

#Preview {
    TotalView()
}
