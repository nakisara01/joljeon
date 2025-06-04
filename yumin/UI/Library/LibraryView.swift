//
//  LibraryView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var drawingModel: DrawingModel
    var body: some View {
        ZStack {
            Image("LibraryViewBackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 90) {
                    ForEach(0..<drawingModel.savedDrawings.count, id: \.self) { index in
                        if index % 4 == 0 {
                            ZStack(alignment: .topLeading) {
                                Image("LibraryBar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal)
                                    .offset(y: 40)
                                    .zIndex(0)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 4, y: 4)
                                
                                HStack(spacing: 95) {
                                    ForEach(index..<min(index + 4, drawingModel.savedDrawings.count), id: \.self) { drawingIndex in
                                        NavigationLink(destination: DrawingDetailView(drawingImage: drawingModel.savedDrawings[drawingIndex], drawingIndex: drawingIndex)) {
                                            VStack {
                                                ZStack {
                                                    Image("RealLibraryFrame")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 110, height: 110)
                                                        .shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8)

                                                    Image(uiImage: drawingModel.savedDrawings[drawingIndex])
                                                        .resizable()
                                                        .scaledToFit()
                                                        .aspectRatio(1, contentMode: .fit)
                                                        .frame(width: 100, height: 100)
                                                        .opacity(0.3)

                                                    Text(String(format: "%03d", drawingIndex + 1))
                                                        .fontWeight(.bold)
                                                        .font(.system(size: 20))
                                                        .foregroundColor(Color.brown.opacity(0.7))
                                                        .padding(.horizontal, 8)
//                                                        .background(Color.white.opacity(0.4))
                                                        .offset(x: 24, y: 37)
                                                        .zIndex(2)
                                                }
                                            }
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                    if (drawingModel.savedDrawings.count - index) < 4 {
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.leading, 124)
                                .zIndex(1)
                            }
                        }
                    }
                }
                    .padding() // Add padding around the main content VStack
                }
                .padding(.top, 200)
            }
            .padding(.top, 30)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LibraryView()
        .environmentObject(DrawingModel())
}
