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
                .padding(.top,10)
                .padding(.bottom, 30)
            
            ScrollView{
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                Text("hi")
                //설명 UI가 들어갈 자리
            }
            .frame(width:880, height: 920)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            .padding(.bottom, 40)

        }
    }
}

#Preview {
    TotalView()
}
