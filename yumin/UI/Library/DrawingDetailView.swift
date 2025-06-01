import SwiftUI

struct DrawingDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let drawingImage: UIImage
    let drawingIndex: Int
    
    var body: some View {
        ZStack {
            // Background Image
            Image("LibraryViewBackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                // Top Bar (similar to the image)
                
                Spacer()
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward.2")
                            .font(.system(size: 36))
                            .foregroundColor(.white) // Adjust color as needed
                    }
                    .padding(.leading, 200)
                    Spacer()
                    
                    Text(String(format: "%03d", drawingIndex + 1))
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white) // Adjust color as needed
                        .padding(.trailing, 200)
                    
                }
                .padding(.horizontal)
                .padding(.top, 60) // Adjust padding from top
                
                // Use ZStack to layer the bar image and the drawing image
                ZStack(alignment: .top) { // Align content to the top
                    
                    // Display the Drawing Image
                    Image(uiImage: drawingImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 800, maxHeight: 800) // Adjust max frame size
                        .shadow(radius: 10) // Add shadow
                        .zIndex(1) // Ensure drawing is above the bar
                }

                Spacer()
            }
        }
        .navigationBarHidden(true) // Hide the default navigation bar
    }
}

#Preview {
    DrawingDetailView(drawingImage: UIImage(systemName: "photo") ?? UIImage(), drawingIndex: 0)
} 
