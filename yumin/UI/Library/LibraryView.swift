//
//  LibraryView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack{
            Image("LibraryViewBackground")
                .resizable()
                .ignoresSafeArea()
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    LibraryView()
}
