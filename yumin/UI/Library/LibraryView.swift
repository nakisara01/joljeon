//
//  LibraryView.swift
//  yumin
//
//  Created by 나현흠 on 5/3/25.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject var drawingModel: DrawingModel
    
    // Removed: Define columns for the grid (4 items per row)
    // private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        ZStack {
            Image("LibraryViewBackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack{
            ScrollView {
                // Remove the outer HStack for centering and keep main VStack left aligned
                VStack(alignment: .leading, spacing: 60) { // Align the main content VStack to the leading edge
                    ForEach(0..<drawingModel.savedDrawings.count, id: \.self) { index in
                        if index % 4 == 0 { // Start a new row for every 4 items
                            // Use ZStack to layer drawings on top of the bar, aligned to top leading
                            ZStack(alignment: .topLeading) { // Align content to top leading for positioning
                                // Add LibraryBar image (background layer)
                                Image("LibraryBar") // Make sure you have a LibraryBar image asset
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity) // Adjust width as needed
                                    .padding(.horizontal) // Match padding with HStack for alignment
                                    .offset(y: 100) // Adjust vertical position of the bar - may need fine tuning
                                    .zIndex(0) // Ensure bar is behind drawings
                                
                                // HStack for the row of drawings (foreground layer)
                                // Align the drawing HStack to the leading edge and add Spacer based on item count
                                HStack(spacing: 40) { // Increased spacing between drawings
                                    // Add the 4 drawings for the current row
                                    ForEach(index..<min(index + 4, drawingModel.savedDrawings.count), id: \.self) { drawingIndex in
                                        // Wrap each item in NavigationLink
                                        NavigationLink(destination: DrawingDetailView(drawingImage: drawingModel.savedDrawings[drawingIndex], drawingIndex: drawingIndex)) {
                                            VStack {
                                                // Display item number
                                                Text(String(format: "%03d", drawingIndex + 1))
                                                    .font(.headline)
                                                    .foregroundColor(.black) // Adjust color as needed
                                                    .padding(.bottom, 5)
                                                
                                                // Display the image
                                                Image(uiImage: drawingModel.savedDrawings[drawingIndex])
                                                    .resizable()
                                                    .scaledToFit()
                                                    .aspectRatio(1, contentMode: .fit) // Maintain aspect ratio
                                                    .frame(width: 180, height: 180) // Set a consistent size for drawings
                                                    .clipShape(RoundedRectangle(cornerRadius: 10)) // Adjust corner radius
                                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1)) // Adjust corner radius and border
                                                    // Add white shadow
                                                    .shadow(color: .white.opacity(0.8), radius: 10) // Add white shadow with some opacity and radius
                                            }
                                        }
                                        // Set the button style to plain to remove default NavigationLink appearance
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                    
                                    // Add Spacer to push content to the left if less than 4 items
                                    if (drawingModel.savedDrawings.count - index) < 4 {
                                        Spacer() // Push remaining items to the left
                                    }
                                }
                                .padding(.horizontal) // Add horizontal padding to the row
                                .padding(.leading, 65)
                                .zIndex(1) // Ensure drawings are above the bar
                            }
                        }
                    }
                }
                    .padding() // Add padding around the main content VStack
                    
                    // Remove the Spacer here
                    // Spacer() // Push content to the center
                }
                .padding(.top, 200)
            }
            .padding(.top, 30)
        }
        // Hide the default navigation bar provided by NavigationView
        .navigationBarHidden(true)
    }
}

#Preview {
    LibraryView()
        .environmentObject(DrawingModel())
}

