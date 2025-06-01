//
//  IntroduceView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct IntroduceView: View {
    // State variable to control the presentation of the admin sheet
    @State private var showingAdminSheet = false
    @EnvironmentObject var drawingModel: DrawingModel
    
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
                // Add a long press gesture to the IntroduceLabel
                .onLongPressGesture(minimumDuration: 3) { // 5 seconds minimum duration
                    // Action to perform after a long press
                    showingAdminSheet = true // Show the admin sheet
                }
            
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
        // Present the AdminView as a sheet when showingAdminSheet is true
        .sheet(isPresented: $showingAdminSheet, onDismiss: { // Correct argument label and position for onDismiss
            // Reload drawings when the AdminView sheet is dismissed
            drawingModel.loadDrawings()
        }) { // This is the content closure for the sheet
            AdminView()
                .environmentObject(drawingModel) // Pass the environment object
        }
    }
}

#Preview {
    TotalView()
}
