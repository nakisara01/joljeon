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
                    .padding(.leading, 135)
                    Spacer()
                    
                    Text(String(format: "%03d", drawingIndex + 1))
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white) // Adjust color as needed
                        .padding(.trailing, 135)
                    
                }
                .padding(.horizontal)
                .padding(.top, 60) // Adjust padding from top
                
                // Use ZStack to layer the drawing image on top of the "BigFrame" image
                ZStack(alignment: .center) {
                    Image("realreal")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 750, maxHeight: 750)
                        .zIndex(0)

                    Image(uiImage: drawingImage)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 710, height: 710)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black.opacity(0.3), lineWidth: 10)
                                .blur(radius: 6)
                                .offset(x: 1, y: 1)
                                .mask(
                                    Rectangle()
                                )
                        )
                        
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
