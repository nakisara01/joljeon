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
            Image("rrrrpppp")
                
                .padding(.top,30)
                .padding(.bottom, 40)
                .ignoresSafeArea()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 4, y: 4)
                .frame(maxWidth: .infinity, alignment: .top)
                // Add a long press gesture to the IntroduceLabel
                .onLongPressGesture(minimumDuration: 3) { // 5 seconds minimum duration
                    // Action to perform after a long press
                    showingAdminSheet = true // Show the admin sheet
                }
            
            VStack(spacing: 0) {
                Image("Prologue")
                    .padding(.bottom, 50)
                Image("IntroduceImage")
                    .padding(.bottom, 80)
            }

        }
        // Present the AdminView as a sheet when showingAdminSheet is true
        .sheet(isPresented: $showingAdminSheet, onDismiss: { // Correct argument label and position for onDismiss
            // Reload drawing s when the AdminView sheet is dismissed
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
